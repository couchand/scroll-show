# scroll-show

webdriver = require 'selenium-webdriver'

module.exports = (pages, repeat=yes, delay=15, startDelay=delay*100) ->
  return if !pages? or pages.length is 0

  _pages = pages.slice()

  console.log "Loading driver..."

  driver = new webdriver.Builder()
    .withCapabilities(webdriver.Capabilities.firefox())
    .build()

  driver.manage().timeouts().setScriptTimeout 3*60*1000

  loadPage = (page) ->
    console.log "Navigating to #{page}..."
    driver.get(page).then ->
      console.log "Auto-scrolling..."
      driver.executeAsyncScript("""
                           var cb = arguments[arguments.length - 1];
                           function pageScroll() {
                               window.scrollBy(0,1);
                               if (document.documentElement.scrollTop == document.documentElement.scrollTopMax)
                                 cb();
                               else
                                 scrolldelay = setTimeout(pageScroll,#{delay});
                           }
                           setTimeout(pageScroll,#{startDelay});
                           """).then ->
        p = _pages.shift()
        if p?
          loadPage p
        else
          if repeat
            console.log "\nRepeating..."
            _pages = pages.slice()
            loadPage _pages.shift()
          else
            driver.quit()

  loadPage _pages.shift()
