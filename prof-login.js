const SUPABASE_URL = "https://xhasvagsodoctsqbfwkw.supabase.co";
const SUPABASE_KEY = "sb_publishable_xkkU9fI3Gv9dpEf7kadVBw_9GrcLZzr";

// o SDK fica em window.supabase
const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

const btn = document.querySelector("#btn-prof");

btn.addEventListener("click", async () => {
  const email = document.querySelector("#email").value.trim();
  const senha = document.querySelector("#senha").value.trim();

  const { data, error } = await supabaseClient.auth.signInWithPassword({
    email,
    password: senha,
  });

  if (error) {
    alert("Login inválido: " + error.message);
    return;
  }

  // busca perfil
  const { data: profile, error: profileError } = await supabaseClient
    .from("profiles")
    .select("role")
    .eq("id", data.user.id)
    .single();

  if (profileError || !profile) {
    alert("Perfil não encontrado.");
    return;
  }

  if (profile.role !== "admin") {
    alert("Sem permissão");
    return;
  }

  window.location.href = "admin.html";
});

