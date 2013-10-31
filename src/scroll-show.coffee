# scroll-show

webdriver = require 'selenium-webdriver'

module.exports = (pages) ->
  driver = new webdriver.Builder()
    .withCapabilities(webdriver.Capabilities.firefox())
    .build()

  pages.forEach (page) ->
    driver.get page
    driver.executeScript """
                         function pageScroll() {
                             window.scrollBy(0,1);
                             scrolldelay = setTimeout(pageScroll,10);
                         }
                         pageScroll();
                         """
    console.log "waiting"
    driver.wait 10000

  driver.quit()
