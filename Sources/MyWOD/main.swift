

import Foundation
import Kitura
import LoggerAPI
import HeliumLogger
import MyWODCore


HeliumLogger.use(LoggerMessageType.debug)

let controller = Controller()

Log.info("Server will be started on '\(controller.url)'.")

Kitura.addHTTPServer(onPort: controller.port, with: controller.router)

Kitura.run()
