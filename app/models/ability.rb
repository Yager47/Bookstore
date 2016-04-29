class Ability
  include CanCan::Ability

  def initialize(user)
    
    can :read, Book
    can :read, Category

    if user
      can :manage, :all if user.admin?
      can :create, Rating
<<<<<<< HEAD
      can [:create, :read], Order, user_id: user.id
=======
      can :read, Order, user_id: user.id
>>>>>>> fde6d69f324d2e68376e4aa63ad278214ec3cdf2
      can :update, Order, { user_id: user.id, aasm_state: 'in_progress' }
      can :create, OrderItem, :book => { :in_stock? => true }
      can [:update, :delete], OrderItem, :order => { aasm_state: 'in_progress' }
      can :manage, User, id: user.id
    end
  end
end
