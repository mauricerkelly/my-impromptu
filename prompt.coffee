module.exports = (Impromptu, section) ->
  system = Impromptu.module.require 'impromptu-system'

  section 'user',
    content: [system.user, system.shortHost]
    format: (user, host) ->
      return if user.trim() is process.env.DEFAULT_USER
      "#{user}@#{host}"
    background: 'black'

  section 'pwd',
    content: system.prettyPwd
    background: 'blue'
    foreground: 'black'

  section 'end',
    content: '\n$'
    foreground: 'blue'
    options:
      newlines: true
