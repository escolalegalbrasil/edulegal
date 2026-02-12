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

  console.log("Tentando login:", username, pin);

  try {

    const url =
      `${SUPABASE_URL}/rest/v1/students` +
      `?select=*` +
      `&username=eq.${encodeURIComponent(username)}` +
      `&pin=eq.${encodeURIComponent(pin)}` +
      `&active=eq.true` +
      `&limit=1`;

    console.log("URL:", url);

    const res = await fetch(url, {
      headers: {
        apikey: SUPABASE_ANON_KEY,
        Authorization: `Bearer ${SUPABASE_ANON_KEY}`
      }
    });

    console.log("Status HTTP:", res.status);

    const data = await res.json();

    console.log("Resultado:", data);

    if (!data || data.length === 0) {
      return showError("Usuário ou PIN inválido.");
    }

    const student = data[0];

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




