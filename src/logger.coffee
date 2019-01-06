{ createLogger, format, transports } = require('winston')
{ combine, timestamp, label, printf } = format

logger = createLogger({
  level: 'debug',
  format: combine(
    timestamp(),
    printf((info) -> "#{info.timestamp} #{info.level}: #{info.message}")),
  transports: [ new transports.Console(), ],
})

module.exports = logger
