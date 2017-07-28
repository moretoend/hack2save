class InstitutionsController < ApplicationController
    respond_to :json

    def index
        @institutions = Institution.all
    end

    def new
        @institution = Institution.new
    end

    def create
        @institution = Institution.new(institutions_params)
        if @institution.save
            flash[:success] = "Instituição criada com sucesso!"
            redirect_to @institution
        else
            render 'new'
        end
    end

    private
    def institutions_params
        params.require(:institution).permit(:name, :description, :category)
    end

end
