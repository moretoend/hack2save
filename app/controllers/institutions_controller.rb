class InstitutionsController < ApplicationController
    before_action :get_institution, only: [:edit, :update, :show]

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

    def show
    end

    def edit
    end

    def update
        if @institution.update_attributes(institutions_params)
            flash[:success] = "Instituição atualizada!"
            redirect_to @institution
        else
            render 'edit'
        end
    end

    private

    def get_institution
      @institution = Institution.find(params[:id])
    end

    def institutions_params
        params.require(:institution).permit(:name, :description, :category)
    end

end
