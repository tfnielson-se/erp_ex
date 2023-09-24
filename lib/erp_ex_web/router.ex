defmodule ErpExWeb.Router do
  use ErpExWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ErpExWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do

    plug :accepts, ["json"]

  end

  scope "/", ErpExWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/api/users", UserController, :index

    # Users
    live "/users", UserLive.Index, :index
    live "/users/new", UserLive.Index, :new
    live "/users/:id/edit", UserLive.Index, :edit

    live "/users/:id", UserLive.Show, :show
    live "/users/:id/show/edit", UserLive.Show, :edit

    # Items
    live "/items", ItemLive.Index, :index
    live "/items/new", ItemLive.Index, :new
    live "/items/:id/edit", ItemLive.Index, :edit

    live "/items/:id", ItemLive.Show, :show
    live "/items/:id/show/edit", ItemLive.Show, :edit

    # Clients
    live "/clients", ClientLive.Index, :index
    live "/clients/new", ClientLive.Index, :new
    live "/clients/:id/edit", ClientLive.Index, :edit

    live "/clients/:id", ClientLive.Show, :show
    live "/clients/:id/show/edit", ClientLive.Show, :edit

    # Projects
    live "/projects", ProjectLive.Index, :index
    live "/projects/new", ProjectLive.Index, :new
    live "/projects/:id/edit", ProjectLive.Index, :edit

    live "/projects/:id", ProjectLive.Show, :show
    live "/projects/:id/show/edit", ProjectLive.Show, :edit

    live "/purchase_orders", PurchaseOrderLive.Index, :index
    live "/purchase_orders/new", PurchaseOrderLive.Index, :new
    live "/purchase_orders/:id/edit", PurchaseOrderLive.Index, :edit

    live "/purchase_orders/:id", PurchaseOrderLive.Show, :show
    live "/purchase_orders/:id/show/edit", PurchaseOrderLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", ErpExWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:erp_ex, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ErpExWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
