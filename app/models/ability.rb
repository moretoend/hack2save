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
        Permission.can_approve?(subscription.institution, user)
      end
  end
end
