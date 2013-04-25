module.exports = (Impromptu, section) ->
  system = Impromptu.module.require 'impromptu-system'

  section 'user',
    content: [system.user, system.host]
    format: (user, host) ->
      return if user.trim() is process.env.DEFAULT_USER
      "#{user}@#{host}"
    background: 'green'
    foreground: 'white'

  section 'pwd',
    content: system.prettyPwd
    background: 'blue'
    foreground: 'white'
