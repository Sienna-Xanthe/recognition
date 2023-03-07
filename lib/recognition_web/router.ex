defmodule RecognitionWeb.Router do
  use RecognitionWeb, :router
  use Plug.ErrorHandler

   defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
     conn |> json(%{errors: message}) |> halt()
   end

   defp handle_errors(conn, %{reason: %{message: message}}) do
     conn |> json(%{errors: message}) |> halt()
   end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
     plug RecognitionWeb.Auth.Pipeline
     plug RecognitionWeb.Auth.SetAccount
   end

  scope "/api", RecognitionWeb do
    pipe_through :api
    post "/accounts/create", AccountController, :create
    post "/accounts/sign_in", AccountController, :sign_in
  end

  scope "/api", RecognitionWeb do
     pipe_through [:api, :auth]
     get "/accounts/show/:id", AccountController, :show
     post "/accounts/update", AccountController, :update
     get "/accounts/sign_out", AccountController, :sign_out
     get "/accounts/refresh_session", AccountController, :refresh_session
   end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:recognition, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: RecognitionWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
