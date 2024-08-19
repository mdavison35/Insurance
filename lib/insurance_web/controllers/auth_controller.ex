defmodule InsuranceWeb.AuthController do
  use InsuranceWeb, :controller

  # redirects to external login service then back to home
  def login(conn, _params) do
    redirect(conn, external: AuthPlug.get_auth_url(conn, ~p"/"))
  end

  # redirects to external logout service then back to home
  def logout(conn, _params) do
    conn
    |> AuthPlug.logout()
    |> put_status(302)
    |> redirect(to: ~p"/")
  end
end
