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
    // Monta URL com filtros (mais seguro do que concatenar string)
    const endpoint = new URL(`${SUPABASE_URL}/rest/v1/students`);
    endpoint.search = new URLSearchParams({
      select: "id,name,username,active",
      "username": `eq.${username}`,
      "pin": `eq.${pin}`,
      "active": "eq.true",
      limit: "1",
    }).toString();

    const res = await fetch(endpoint.toString(), {
      method: "GET",
      headers: {
        apikey: SUPABASE_ANON_KEY,
        Authorization: `Bearer ${SUPABASE_ANON_KEY}`,
        Accept: "application/json",
      },
    });

    // Se der erro, vamos ler o texto pra saber o motivo (RLS, permissão, etc.)
    if (!res.ok) {
      const errText = await res.text().catch(() => "");
      console.error("HTTP:", res.status, errText);
      return showError(`Erro no servidor (HTTP ${res.status}). Veja o Console.`);
    }

    const data = await res.json();

    console.log("Resultado:", data); // <- DEBUG

    if (!Array.isArray(data) || data.length === 0) {
      return showError("Usuário ou PIN inválido.");
    }

    // Login OK
    const student = data[0];
    localStorage.setItem("edulegal_student", JSON.stringify(student));

    window.location.href = "chat.html";
  } catch (err) {
    console.error("Erro:", err);
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



