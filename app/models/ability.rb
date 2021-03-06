class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
        can :manage , :all
    else
        can :read, :all
        can :update, Post do |post|
            post.user == user 
        end 

        can :destroy, Post do |post|
            post.user == user 
        end

        can :create , Post
        can :index , Post 

        can :destroy, Event do |event|
            event.user == user 
        end

        can :update, User do |us|
            user == us
        end
        can :destroy, Comment do |comment|
            comment.user == user 
        end
        can :update, Comment do |comment|
            comment.user == user 
        end
        can :destroy, Message do |message|
            message.user == user
        end
        can :create , Message
        can :create , Room 
        can :create , RoomMessage
        can :destroy , RoomMessage do |roommessage|
            roommessage.user == user 
        end
        can :destroy ,Message do |message|
            message.user == user 
        end
        can :destroy , Conversation do |conversation|
            conversation.user == user
        end

        can :destroy , ChatroomMessage do |chatroommessage|
            chatroommessage.user  == user
        end
        
    
      
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
