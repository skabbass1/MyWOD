

import Foundation
import MyWODCore


print(ScheduleRequest.get(forDate: Date()))

RunLoop.main.run(until: Date(timeIntervalSinceNow: 5))
