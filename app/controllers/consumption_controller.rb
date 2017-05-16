class ConsumptionController < ApplicationController

	before_action :authenticate_user!

	def register

		ActiveRecord::Base.transaction do

			payer_record = Record.find params[:payer_record_id]

			group = payer_record.group

			if params[:consumers].nil? then
				@consumers = group.records.where(enabled: true).map { |r| {record_id: r.id} }
			else
				@consumers = params[:consumers]
			end

			if (group.purpose == "ammount") then
				@paid = params[:paid].to_f
				@paid_count = @consumers.size
			else
				@paid = 1
				@paid_count = 1
			end

			@taken = @paid / (@consumers.size * 1.0)

			payer_record.paid += @paid
			payer_record.paid_count += @paid_count
			payer_record.last_payment = DateTime.now
			payer_record.last_paid = @paid
			payer_record.save!

			@consumers.each do |r|
				record = Record.find r[:record_id]

				record.taken += @taken
				record.taken_count += 1
				record.last_taking = DateTime.now
				record.last_taken = @taken
				record.save!
			end

			respond_to do |format|
				format.json { render json: {paid: @paid}, status: :ok }
			end

		end
	end
end
