// ===== Supabase (Opção A - direto do front) =====
const SUPABASE_URL = "https://xhasvagsodoctsqbfwkw.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_xkkU9fI3Gv9dpEf7kadVBw_9GrcLZzr";

// Seletores
const btnLogin = document.querySelector(".btn-login");
const usernameEl = document.querySelector("#username");
const pinEl = document.querySelector("#pin");

// Helper: alerta padrão
function showError(msg) {
  alert(msg);
}

async function login() {
  const username = (usernameEl?.value || "").trim();
  const pin = (pinEl?.value || "").trim();

  if (!username) return showError("Digite o usuário.");
  if (!pin) return showError("Digite o PIN.");
  if (!/^\d{4,8}$/.test(pin)) return showError("PIN inválido (use 4 a 8 números).");

  try {
    // Busca aluno por username + pin + active=true
    const url =
      `${SUPABASE_URL}/rest/v1/students` +
      `?select=id,name,username,active` +
      `&username=eq.${encodeURIComponent(username)}` +
      `&pin=eq.${encodeURIComponent(pin)}` +
      `&active=eq.true` +
      `&limit=1`;

    const res = await fetch(url, {
      method: "GET",
      headers: {
        apikey: SUPABASE_ANON_KEY,
        Authorization: `Bearer ${SUPABASE_ANON_KEY}`,
        "Content-Type": "application/json",
      },
    });

    if (!res.ok) {
      // 401/403 geralmente é RLS/policy
      throw new Error(`HTTP ${res.status}`);
    }

    const data = await res.json();

    if (!Array.isArray(data) || data.length === 0) {
      return showError("Usuário ou PIN inválido.");
    }

    // Login OK
    const student = data[0];
    localStorage.setItem("edulegal_student", JSON.stringify(student));

    // Próxima tela (vamos criar já já)
    window.location.href = "chat.html";
  } catch (err) {
    console.error(err);
    showError("Erro de conexão com o servidor");
  }
}

// Clique no botão
btnLogin?.addEventListener("click", (e) => {
  e.preventDefault();
  login();
});

// Enter no PIN
pinEl?.addEventListener("keydown", (e) => {
  if (e.key === "Enter") login();
});


