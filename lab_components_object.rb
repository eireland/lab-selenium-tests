class LabComponentsObject

    IFRAME = {id: 'iframe-interactive'}
    TEXTRESULT = { css: '.textBox'}
    BUTTON = { id: 'button'}
    SLIDER =  {css: '.ui-slider-handle'}
    DROPDOWNMENU = {id: 'pulldown'}
    DROPDOWNOPTION1 = {xpath: '//span/ul/li[@data-val="Option 1"]'} #<option>Option 1
    DROPDOWNOPTION2 = {xpath: '//span/ul/li[@data-val="Option 2"]'}
    CHECKBOX = {css: '.interactive-checkbox'}
    VRADIO1 = {xpath: '//label[@for="radio-0"]'}
    VRADIO2 = {xpath: '//label[@for="radio-1"]'}
    VRADIO3 = {xpath: '//label[@for="radio-2"]'} #Disabled radio button
    HRADIO1 = {xpath: '//label[@for="radio-horizontal-0"]'}
    HRADIO2 = {xpath: '//label[@for="radio-horizontal-1"]'}
    HRADIO3 = {xpath: '//label[@for="radio-horizontal-2"]'} #Disabled radio button
    TEXTCLICK = {id: 'clickable-text'}
    IMAGECLICK = {id: 'clickable-img'}
    PLAYBUTTON = {css: '.play-pause'}
    PAUSEBUTTON = {css: '.play-pause'}
    RESETBUTTON = {css: '.reset'}
    RELOADICON = {id: 'interactive-reload-icon'}

    attr_reader :driver

    def initialize(driver)
      @driver = driver
      visit
      #verify_page
      switch_to_interactive
    end

    def visit
      @driver.get ENV['base_url']
    end

    def button_click
      puts "Click button"
      wait_for{ displayed?(BUTTON)}
      @driver.find_element(BUTTON).click
      verify_action(BUTTON)
    end

    def slider_move
      puts "Move slider"
      # dnd_javascript = File.read(Dir.pwd + 'dnd.js')
      slider = @driver.find_element(SLIDER)
      @driver.action.drag_and_drop_by(slider, 100, 0).perform
      # slider_width = slider.size.width
      # @driver.execute_script(dnd_javascript+"$('#column-a').simulateDragDrop({ dropTarget: '#column-b'});")
      verify_action(SLIDER)
    end


    def dropdown_select_1
      @driver.find_element(DROPDOWNMENU).click
      puts "Click dropdown option 1"
      @driver.find_element(DROPDOWNOPTION1).click
      verify_action(DROPDOWNOPTION1)
    end

    def dropdown_select_2
      @driver.find_element(DROPDOWNMENU).click
      puts "Click dropdown option 2"
      @driver.find_element(DROPDOWNOPTION2).click
      verify_action(DROPDOWNOPTION2)
    end

    def check_box
      puts "Check the box"
      @driver.find_element(CHECKBOX).click
      verify_action(CHECKBOX)
    end

    def uncheck_box
      puts "Uncheck the box"
      @driver.find_element(CHECKBOX).click
      verify_action(CHECKBOX)
    end

    def vradio_select_1
      puts "Select vertical radio 1"
      option1 = @driver.find_element(VRADIO1)
      option1.click
      verify_action(VRADIO1)
    end

    def vradio_select_2
      puts "Select vertical radio 2"
      option2 = @driver.find_element(VRADIO2)
      option2.click
      verify_action(VRADIO2)
    end

    def vradio_select_3
      puts "Select vertical radio disabled"
      @driver.find_element(VRADIO3).click
      verify_action(VRADIO3)
    end

    def hradio_select_1
      puts "Select horizontal radio 1"
      @driver.find_element(HRADIO1).click
      verify_action(HRADIO1)
    end

    def hradio_select_2
      puts "Select horizontal radio 2"
      @driver.find_element(HRADIO2).click
      verify_action(HRADIO2)
    end

    def hradio_select_3
      puts "Select horizontal radio disabled"
      driver.find_element(VRADIO3).click
      verify_action(VRADIO3)
    end

    def text_click
      puts "Click text"
      @driver.find_element(TEXTCLICK).click
      verify_action(TEXTCLICK)
    end

    def image_click
      puts "Click image"
      @driver.find_element(IMAGECLICK).click
      verify_action(IMAGECLICK)
    end

    def play_click
      puts "Click Play"
      @driver.find_element(PLAYBUTTON).click
      verify_action(PLAYBUTTON)
    end

    def pause_click
      puts "Click Play"
      @driver.find_element(PAUSEBUTTON).click
      verify_action(PAUSEBUTTON)
    end


    def reset_click
      puts "Click Play"
      @driver.find_element(RESETBUTTON).click
      verify_action(RESETBUTTON)
    end

    def reload
      puts "Reload"
      wait_for{ displayed?(RELOADICON )}
      @driver.find_element(RELOADICON).click
    end

    private
    def verify_page
      sleep(20)
      expect(@driver.title).to eql('Lab Interactive Browser: Components')
    end

    def switch_to_interactive
      frame = @driver.find_element(IFRAME)
      @driver.switch_to.frame(frame)
    end


    def verify_action(action)
      puts 'in verify action'

      case (action)
        when BUTTON
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Button clicked'
        when SLIDER
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts "slider value is #{text_result}"
          expect text_result.include? 'Slider moved, value 42'
        when DROPDOWNOPTION1
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Pulldown Option 2 selected'
        when DROPDOWNOPTION2
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Pulldown Option 2 selected'
        when CHECKBOX
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Checkbox state changed'
        when VRADIO1
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Radio(vertical) Option 1 selected)'
        when VRADIO2
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Radio(vertical) Option 2 selected)'
        when VRADIO3
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Radio(vertical) Option 1 selected)' #should equal the same as previous text because disabled
        when HRADIO1
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Radio(horizontal) Option 1 selected)'
        when HRADIO2
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Radio(horizontal) Option 1 selected)'
        when HRADIO3
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Radio(horizontal) Option 1 selected)' #should equal the same as previous text because disabled
        when TEXTCLICK
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Text clicked'
        when IMAGECLICK
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Image clicked'
        when PLAYBUTTON
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Play clicked'
        when PAUSEBUTTON
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Pause clicked'
        when RESETBUTTON
          wait_for { displayed?(TEXTRESULT) }
          text_result = @driver.find_element(TEXTRESULT).attribute("text-data")
          puts text_result
          expect text_result.include? 'Interactive Component Test'
      end
      puts "-------------------------------------------"
    end

    def wait_for(seconds=25)
      puts "Waiting"
      Selenium::WebDriver::Wait.new(:timeout => seconds).until { yield }
    end

    def displayed?(locator)
      driver.find_element(locator).displayed?
      puts "#{locator} found"
      true
    rescue Selenium::WebDriver::Error::NoSuchElementError
      puts "#{locator} not found"
      false
    end
end