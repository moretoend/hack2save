class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)

      can :manage, Institution
      can :manage, Permission
      can :manage, Job
      can :manage, User

      can :create, Subscription
      can :read, Subscription, user_id: user.id
      can [:update, :read], Subscription do |subscription|
        subscription.permissions.where(user_id: user.id).exit?
      end
      cannot :destroy, Subscription

  end
end
