class ReportController < ApplicationController
    def create
        logger.info("Create called with #{params}")
    end
end
