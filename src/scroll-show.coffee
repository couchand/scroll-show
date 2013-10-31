# scroll-show

webdriver = require 'selenium-webdriver'

module.exports = (pages, delay=15) ->
  return if !pages? or pages.length is 0

  driver = new webdriver.Builder()
    .withCapabilities(webdriver.Capabilities.firefox())
    .build()

  driver.manage().timeouts().setScriptTimeout 3*60*1000

  loadPage = (page) ->
    driver.get(page).then ->
      driver.executeAsyncScript("""
                           var cb = arguments[arguments.length - 1];
                           function pageScroll() {
                               window.scrollBy(0,1);
                               if (document.documentElement.scrollTop == document.documentElement.scrollTopMax)
                                 cb();
                               else
                                 scrolldelay = setTimeout(pageScroll,#{delay});
                           }
                           pageScroll();
                           """).then ->
        p = pages.shift()
        if p?
          loadPage p
        else
          driver.quit()

  loadPage pages.shift()
