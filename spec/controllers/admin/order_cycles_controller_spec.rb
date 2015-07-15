require 'spec_helper'

module Admin
  describe OrderCyclesController do
    include AuthenticationWorkflow
    let!(:distributor_owner) { create_enterprise_user enterprise_limit: 2 }

    before do
      controller.stub spree_current_user: distributor_owner
    end

    describe "new" do
      describe "when the user manages no distributor enterprises suitable for coordinator" do
        let!(:distributor) { create(:distributor_enterprise, owner: distributor_owner, confirmed_at: nil) }

        it "redirects to order cycles index" do
          spree_get :new
          expect(response).to redirect_to admin_order_cycles_path
        end
      end

      describe "when the user manages a single distributor enterprise suitable for coordinator" do
        let!(:distributor) { create(:distributor_enterprise, owner: distributor_owner) }

        it "renders the new template" do
          spree_get :new
          expect(response).to render_template :new
        end
      end

      describe "when a user manages multiple enterprises suitable for coordinator" do
        let!(:distributor1) { create(:distributor_enterprise, owner: distributor_owner) }
        let!(:distributor2) { create(:distributor_enterprise, owner: distributor_owner) }
        let!(:distributor3) { create(:distributor_enterprise) }

        it "renders the set_coordinator template" do
          spree_get :new
          expect(response).to render_template :set_coordinator
        end

        describe "and a coordinator_id is submitted as part of the request" do
          describe "when the user manages the enterprise" do
            it "renders the new template" do
              spree_get :new, coordinator_id: distributor1.id
              expect(response).to render_template :new
            end
          end

          describe "when the user does not manage the enterprise" do
            it "renders the set_coordinator template and sets a flash error" do
              spree_get :new, coordinator_id: distributor3.id
              expect(response).to render_template :set_coordinator
              expect(flash[:error]).to eq "You don't have permission to create an order cycle coordinated by that enterprise"
            end
          end
        end
      end
    end

    describe "bulk_update" do
      let(:oc) { create(:simple_order_cycle) }
      let!(:coordinator) { oc.coordinator }

      context "when I manage the coordinator of an order cycle" do
        before { create(:enterprise_role, user: distributor_owner, enterprise: coordinator) }

        it "updates order cycle properties" do
          spree_put :bulk_update, order_cycle_set: { collection_attributes: { '0' => {
            id: oc.id,
            orders_open_at: Date.today - 21.days,
            orders_close_at: Date.today + 21.days,
          } } }

          oc.reload
          expect(oc.orders_open_at.to_date).to eq Date.today - 21.days
          expect(oc.orders_close_at.to_date).to eq Date.today + 21.days
        end

        it "does nothing when no data is supplied" do
          expect do
            spree_put :bulk_update
          end.to change(oc, :orders_open_at).by(0)
        end
      end

      context "when I do not manage the coordinator of an order cycle" do
        # I need to manage a hub in order to access the bulk_update action
        let!(:another_distributor) { create(:distributor_enterprise, users: [distributor_owner]) }

        it "doesn't update order cycle properties" do
          spree_put :bulk_update, order_cycle_set: { collection_attributes: { '0' => {
            id: oc.id,
            orders_open_at: Date.today - 21.days,
            orders_close_at: Date.today + 21.days,
          } } }

          oc.reload
          expect(oc.orders_open_at.to_date).to_not eq Date.today - 21.days
          expect(oc.orders_close_at.to_date).to_not eq Date.today + 21.days
        end
      end
    end

    describe "destroy" do
      let!(:distributor) { create(:distributor_enterprise, owner: distributor_owner) }

      describe "when an order cycle becomes non-deletable, and we attempt to delete it" do
        let!(:oc)    { create(:simple_order_cycle, coordinator: distributor) }
        let!(:order) { create(:order, order_cycle: oc) }

        before { spree_get :destroy, id: oc.id }

        it "displays an error message" do
          expect(response).to redirect_to admin_order_cycles_path
          expect(flash[:error]).to eq "That order cycle has been selected by a customer and cannot be deleted. To prevent customers from accessing it, please close it instead."
        end
      end
    end
  end
end
