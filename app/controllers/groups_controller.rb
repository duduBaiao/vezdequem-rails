class GroupsController < ApplicationController

  before_action :authenticate_user!

  before_action :set_group, only: [:show, :edit, :update, :destroy, :leave, :join, :add_participant]

  before_action :set_record, only: [:leave, :join]

  # GET /groups
  # GET /groups.json
  def index
    @groups = current_user.active_groups.order(:name)
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    @is_editing = true
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new_by_user(current_user, group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def leave
    if @record then
      @record.enabled = false
      @record.save!
    else
      @group.users.delete(current_user)
      @group.save
    end

    redirect_to groups_path
  end

  def add_participant

    ActiveRecord::Base.transaction do

      user = User.where({email: params[:email]}).first

      if (!user) then
        password = User.random_password

        user = User.new
        user.email = params[:email]
        user.nick_name = params[:nick_name]
        user.reset_password(password, password)
        user.save!

        user.send_reset_password_instructions
      end

      @record = Record.where({group_id: @group.id, user_id: user.id}).first

      if (!@record) then
        @record = Record.new
        @record.user = user
        @record.group = @group
      else
        @record.enabled = true
      end

      @record.save!

    end
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end

    def set_record
      @record = Record.where({group_id: params[:id], user_id: current_user.id}).first
    end

    def group_params
      params.require(:group).permit(:name, :purpose, :choose_takers)
    end
end
