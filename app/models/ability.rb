class Ability
  include CanCan::Ability

  def initialize(user)
    
    can :read, Book
    can :read, Category

    if user
      can :manage, :all if user.admin?
      can :create, Rating
      can :read, Order, user_id: user.id
      can :update, Order, { user_id: user.id, aasm_state: 'in_progress' }
      can :create, OrderItem, :book => { :in_stock? => true }
      can [:update, :delete], OrderItem, :order => { aasm_state: 'in_progress' }
      can :manage, User, id: user.id
    end
  end
end
