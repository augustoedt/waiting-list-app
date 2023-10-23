defmodule WaitListWeb.Router do
  use WaitListWeb, :router
  use Pow.Phoenix.Router

  alias Pow.Phoenix.{RegistrationController, SessionController}

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {WaitListWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: WaitListWeb.AuthErrorHandler
  end

  pipeline :not_authenticated do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: WaitListWeb.AuthErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/" do
    pipe_through [:browser, :not_authenticated]

    get "/session/new", SessionController, :new
    get "/registration/new", RegistrationController, :new
  end

  # scope "/session/new", WaitListWeb do
  #   pipe_through [:browser, :not_authenticated]
  # end

  # scope "/registration/new", WaitListWeb do
  #   pipe_through [:browser, :not_authenticated]
  # end

  scope "/", WaitListWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/", WaitListWeb do
    pipe_through [:browser, :protected]

    resources "/parties", PartyController
  end

  # Other scopes may use custom stacks.
  # scope "/api", WaitListWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:wait_list, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: WaitListWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
