class InstitutionsSubscriptionsController < ApplicationController
    def index
        @institution = Institution.find(params[:institution_id])
        @subscriptions = @institution.subscriptions.order(:id)
        authorize! :read, @subscriptions.first || Subscription
    end
end
