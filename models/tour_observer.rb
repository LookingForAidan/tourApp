require 'my_logger' 

class TourObserver < ActiveRecord::Observer

    def after_update(record)
    
        @logger = MyLogger.instance
        @logger.logInformation("####################Observer:#")
        @logger.logInformation("+++ TourObserver: The tour of #{record.fname} #{record.lname} has been updated cost is #{record.cost}")
        @logger.logInformation("##############################") 
    end

end

# use the MyLogger instance method to retrieve the single instance/object