class AddVotableToVote < ActiveRecord::Migration
  def change
    add_reference :votes, :votable, polymorphic: true, index: true
  end
end
