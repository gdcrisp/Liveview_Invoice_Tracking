defmodule InvoicesWeb.Router do
  use InvoicesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {InvoicesWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", InvoicesWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/invoices", InvoiceLive.Index, :index
    live "/invoices/new", InvoiceLive.Index, :new
    live "/invoices/:id/edit", InvoiceLive.Index, :edit

    live "/invoices/:id", InvoiceLive.Show, :show
    live "/invoices/:id/show/edit", InvoiceLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", InvoicesWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:invoices, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: InvoicesWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
