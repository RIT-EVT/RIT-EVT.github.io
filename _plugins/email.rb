module Jekyll

  class EmailTag < Liquid::Tag

    MAIL_TO = '&#109;&#97;&#105;&#108;&#116;&#111;&#58;'
    STYLE = 'unicode-bidi: bidi-override; direction: rtl;'
    PARAMETER_SYNTAX = %r!address="(?<address_lit>[^"]+)"|address=(?<address_var>[^\s]+) style="(?<style>[^"]+)"!

    def initialize(tag_name, text, tokens)
      super
      matched = text.strip.match(PARAMETER_SYNTAX)
      if matched
        if matched['address_var']
          @email_var = matched['address_var'].strip
        elsif matched['address_lit']
          @email = matched['address_lit'].strip
        end

        @style = matched['style'].strip
      else
        @email, @style = text.strip.split(%r!\s+!, 2)
      end
    end

    def render(context)
      # We can't encode just once. Reversal of html entities will
      # not work as expected.
      if @email_var
        @email = resolve(context, @email_var)
      end
      reversed = @email.each_char.to_a.reverse.join
      reversed_encoded = encode(reversed)
      obfuscated = encode(@email)

      copy_function = %(
        document.copyEmail = function (event, text) {
            var regexSymbolWithCombiningMarks = /([\\0-\\u02FF\\u0370-\\u1AAF\\u1B00-\\u1DBF\\u1E00-\\u20CF\\u2100-\\uD7FF\\uE000-\\uFE1F\\uFE30-\\uFFFF]|[\\uD800-\\uDBFF][\\uDC00-\\uDFFF]|[\\uD800-\\uDBFF](?![\\uDC00-\\uDFFF])|(?:[^\\uD800-\\uDBFF]|^)[\\uDC00-\\uDFFF])([\\u0300-\\u036F\\u1AB0-\\u1AFF\\u1DC0-\\u1DFF\\u20D0-\\u20FF\\uFE20-\\uFE2F]+)/g;
            var regexSurrogatePair = /([\\uD800-\\uDBFF])([\\uDC00-\\uDFFF])/g;
            var reverse = function (string) {
                string = string
                    .replace(regexSymbolWithCombiningMarks, function ($0, $1, $2) {
                        return reverse($2) + $1;
                    })
                    .replace(regexSurrogatePair, '$2$1');
                var result = '';
                var index = string.length;
                while (index--) {
                    result += string.charAt(index);
                }
                return result;
            };
            text = reverse(text);
            if (window.clipboardData && window.clipboardData.setData) {
                // IE specific code path to prevent textarea being shown while dialog is visible.
                return clipboardData.setData("Text", text);

            } else if (document.queryCommandSupported && document.queryCommandSupported("copy")) {
                var textarea = document.createElement("textarea");
                textarea.textContent = text;
                textarea.style.position = "fixed";  // Prevent scrolling to bottom of page in MS Edge.
                document.body.appendChild(textarea);
                textarea.select();
                try {
                    return document.execCommand("copy");  // Security exception may be thrown by some browsers.
                } catch (ex) {
                    console.warn("Copy to clipboard failed.", ex);
                    return false;
                } finally {
                    document.body.removeChild(textarea);
                    setTimeout(function(){
                        var doc = document, text = event.target, range, selection;
                        if (doc.body.createTextRange) {
                            range = document.body.createTextRange();
                            range.moveToElementText(text);
                            range.select();
                        } else if (window.getSelection) {
                            selection = window.getSelection();
                            range = document.createRange();
                            range.selectNodeContents(text);
                            selection.removeAllRanges();
                            selection.addRange(range);
                        }
                    }, 1);

                }
            }
        };
      )
      if @style == "link"
        %(
          <script type="text/javascript">
          #{copy_function}
          var temp = "#{reversed}";
          document.write('<a oncopy="copyEmail(event, temp)" style="#{STYLE}" href="#{MAIL_TO}#{obfuscated}">#{reversed_encoded}</a>');
          </script>
        )
      elsif @style == "text"
        %(
          <script type="text/javascript">
          #{copy_function}
          var temp = "#{reversed}";
          document.write('<span oncopy="copyEmail(event, temp)" style="#{STYLE}">#{reversed_encoded}</span>');
          </script>
        )
      else
        raise ArgumentError, "Invalid style: #{@style}"
      end

    end

    private
    def encode(str)
      str = str.gsub('@', '&#64;')
      str = str.gsub('.', '&#46;')
    end

    def resolve(context, var_name)
      matched = /^(?<curr>[^.]+)\.(?<next>.+)/.match(var_name)
      if matched
        resolve(context[matched['curr']], matched['next'])
      else
        context[var_name]
      end
    end
  end
end

Liquid::Template.register_tag('email', Jekyll::EmailTag)
