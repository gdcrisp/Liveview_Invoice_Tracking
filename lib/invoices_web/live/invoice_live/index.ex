defmodule InvoicesWeb.InvoiceLive.Index do
  use InvoicesWeb, :live_view

  alias Invoices.InvoicePage
  alias Invoices.InvoicePage.Invoice

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :invoices, InvoicePage.list_invoices())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Invoice")
    |> assign(:invoice, InvoicePage.get_invoice!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Invoice")
    |> assign(:invoice, %Invoice{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Invoices")
    |> assign(:invoice, nil)
  end

  @impl true
  def handle_info({InvoicesWeb.InvoiceLive.FormComponentEdit, {:saved, invoice}}, socket) do
    {:noreply, stream_insert(socket, :invoices, invoice)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    invoice = InvoicePage.get_invoice!(id)
    {:ok, _} = InvoicePage.delete_invoice(invoice)

    {:noreply, stream_delete(socket, :invoices, invoice)}
  end
end
