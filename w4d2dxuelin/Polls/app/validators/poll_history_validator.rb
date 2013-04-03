class PollHistoryValidator < ActiveModel::Validator
  def validate(record)
    unless PollHistory.where("voter_id = ? AND poll_id = ?", record.voter_id, record.poll_id).empty?
      record.errors[:voter_id] << 'User has already completed this poll.'
    end
    unless Poll.where("creator_id = ?", record.creator_id).nil?
      record.errors[:voter_id] << 'User created this poll.'
    end
  end
end
