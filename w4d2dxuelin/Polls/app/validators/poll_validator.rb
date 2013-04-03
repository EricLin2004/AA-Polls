class PollValidator < ActiveModel::Validator
  def validate(record)
    unless Poll.where("creator_id = ?", record.creator_id).nil?
      record.errors[:voter_id] << 'User created this poll.'
    end
  end
end
