class Database

  def fetchUser(username_or_email)
    if !username_or_email.nil?

      if isEmail(username_or_email)
        user = User.find_by_email_normalized(username_or_email.downcase)
        if user.nil?
          user = User.create(
            email: username_or_email,
            email_normalized: username_or_email.downcase
          )
        end
        return user
      else
        User.find_by_username_normalized(username_or_email.downcase)
      end

    end
  end

  def isEmail(username_or_email)
    !username_or_email.index("@").nil?
  end

end
