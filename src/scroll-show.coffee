# scroll-show

webdriver = require 'selenium-webdriver'

module.exports = (pages, delay=15) ->
  return if !pages? or pages.length is 0

  driver = new webdriver.Builder()
    .withCapabilities(webdriver.Capabilities.firefox())
    .build()

  loadPage = (page) ->
    driver.get(page).then ->
      driver.executeScript("""
                           function pageScroll() {
                               window.scrollBy(0,1);
                               scrolldelay = setTimeout(pageScroll,10);
                           }
                           pageScroll();
                           """).then ->
        console.log "waiting"
        driver.sleep(1000 * delay).then ->
          p = pages.shift()
          if p?
            loadPage p
          else
            driver.quit()

  loadPage pages.shift()
