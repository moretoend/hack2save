class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # guest user (not logged in)

    can :manage, User
    
    can :manage, Institution
    # can [:create, :read], Institution
    # can :manage, Institution do |institution|
    #   has_profiles?(institution, %w[owner admin])
    # end

    can :manage, Permission
    # can :manage, Permission do |permission|
      #   institution = permission.institution
      #   return true if has_profiles?(institution, %w[owner])
      #   has_profiles?(institution, %w[admin]) && permission.profile != :owner
      # end
      
    can :manage, Job
    # can :read, Job
    # can :manage, Job do |job|
    #   has_profiles?(job.institution, %w[owner admin])
    # end

    can :create, Subscription
    can :read, Subscription, user_id: user.id
    can [:update, :read], Subscription do |subscription|
      has_profiles?(subscription.institution, %w[owner admin approver])
    end
  end

  def has_profiles?(institution, profiles)
    profiles_user = Permission.where(institution: institution, user: @user).map(&:profile)
    (profiles & profiles_user).any?
  end
end
