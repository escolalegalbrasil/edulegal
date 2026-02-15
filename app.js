const SUPABASE_URL = "https://xhasvagsodoctsqbfwkw.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_xkkU9fI3Gv9dpEf7kadVBw_9GrcLZzr";

const btnLogin = document.querySelector(".btn-login");
const usernameEl = document.querySelector("#username");
const pinEl = document.querySelector("#pin");

function showError(msg) {
  alert(msg);
}

async function login() {
  const username = usernameEl.value.trim();
  const pin = pinEl.value.trim();

  if (!username || !pin) return showError("Preencha username e PIN.");

  try {
    // 1) Login REAL via Supabase Auth
    const email = `${username}@edulegal.app`;
    const { data: authData, error: authError } =
      await window.supabaseClient.auth.signInWithPassword({
        email,
        password: pin
      });

    if (authError || !authData?.session) {
      return showError("Usuário ou PIN inválido.");
    }

    const uid = authData.session.user.id; // auth.uid()

    // 2) Buscar dados do aluno na tabela students (sem checar PIN aqui)
    const url =
      `${SUPABASE_URL}/rest/v1/students` +
      `?select=*` +
      `&username=eq.${encodeURIComponent(username)}` +
      `&active=eq.true` +
      `&limit=1`;

    const res = await fetch(url, {
      headers: {
        apikey: SUPABASE_ANON_KEY,
        Authorization: `Bearer ${SUPABASE_ANON_KEY}`
      }
    });

    const rows = await res.json();
    if (!rows || rows.length === 0) {
      // se não achar aluno ativo, derruba a sessão por segurança
      await window.supabaseClient.auth.signOut();
      return showError("Aluno não encontrado/ativo.");
    }

    const student = rows[0];

    // 3) Guardar sessão mínima local (MVP)
    localStorage.setItem("edulegal_auth_uid", uid);
    localStorage.setItem("edulegal_student", JSON.stringify(student));

    alert("Login OK!");
    window.location.href = "chat.html";
  } catch (err) {
    console.error(err);
    showError("Erro de conexão com o servidor");
  }
}

btnLogin.addEventListener("click", login);

pinEl.addEventListener("keydown", e => {
  if (e.key === "Enter") login();
});





