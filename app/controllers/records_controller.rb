class RecordsController < ApplicationController

  before_action :set_group, only: [:index]

  def index
    @records = @group.records.where({enabled: true}).includes(:user).sort_by { |r| [r.paid - r.taken, r.last_payment || DateTime.now] }
  end

  # DELETE /groups/1/records/1
  # DELETE /groups/1/records/1.json
  def destroy
  	record = Record.find(params[:id])
  	record.enabled = false

  	respond_to do |format|

			if record.save
				format.html { redirect_to groups_url, notice: 'Record was successfully destroyed.' }
				format.json { head :no_content }
			else
				format.html { redirect_to groups_url, alert: 'Could not destroy record!' }
				format.json { render json: record.errors, status: :unprocessable_entity }
			end
		end
  end

  private
    def set_group
      @group = Group.find(params[:group_id])
    end
end
