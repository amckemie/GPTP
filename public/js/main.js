$(document).foundation();
        // function to scroll to about us section
        $.fn.scrollView = function () {
          return this.each(function(){
            $('thml, body').animate({
              scrollTop: $(this).offset().top
            }, 1000);
          });
        }
        // on click event for about us/contact menu
        $('.scroll').click(function(e){
          e.preventDefault();
          $('#about').scrollView();
        })
        // Sign in/Sign Up click events
        $('#vol_in').click(function(e){
          e.preventDefault
          $("#vol_div").addClass("hidden");
          $("#vol_in_form").removeClass("hidden");
          $('#org_div').removeClass("hidden");
          $('#org_in_form').addClass("hidden");
          $('#org_up_form').addClass("hidden");

        })
        $('#vol_up').click(function(e){
          e.preventDefault
          $("#vol_div").addClass("hidden");
          $("#vol_up_form").removeClass("hidden");
          $('#org_div').removeClass("hidden");
          $('#org_in_form').addClass("hidden");
          $('#org_up_form').addClass("hidden");
        })
        $('#org_in').click(function(e){
          e.preventDefault
          $("#org_div").addClass("hidden");
          $("#org_in_form").removeClass("hidden");
          $('#vol_div').removeClass("hidden");
          $('#vol_in_form').addClass("hidden");
          $('#vol_up_form').addClass("hidden");
        })
        $('#org_up').click(function(e){
          e.preventDefault
          $("#org_div").addClass("hidden");
          $("#org_up_form").removeClass("hidden");
          $('#vol_div').removeClass("hidden");
          $('#vol_in_form').addClass("hidden");
          $('#vol_up_form').addClass("hidden");
        })
