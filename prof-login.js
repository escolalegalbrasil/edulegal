const SUPABASE_URL = "https://xhasvagsodoctsqbfwkw.supabase.co";
const SUPABASE_KEY = "sb_publishable_xkkU9fI3Gv9dpEf7kadVBw_9GrcLZzr";

const supabase = supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

const btn = document.querySelector("#btn-prof");

btn.addEventListener("click", async () => {

  const email = document.querySelector("#email").value;
  const senha = document.querySelector("#senha").value;

  const { data, error } = await supabase.auth.signInWithPassword({
    email,
    password: senha
  });

  if(error){
    alert("Login inválido");
    return;
  }

  // busca perfil
  const { data: profile } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", data.user.id)
    .single();

  if(profile.role !== "admin"){
    alert("Sem permissão");
    return;
  }

  window.location.href = "admin.html";

});
