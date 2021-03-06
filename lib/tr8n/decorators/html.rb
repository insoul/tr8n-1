#--
# Copyright (c) 2010-2013 Michael Berkovich, tr8nhub.com
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

class Tr8n::Decorators::Html < Tr8n::Decorators::Base

  def decorate
    return label if options[:skip_decorations]
    return label if translation_key.language == language
    return label unless Tr8n.config.current_translator and Tr8n.config.current_translator.inline?
    return label if translation_key.locked? and not Tr8n.config.current_translator.manager?

    if translation_key.id.nil?
      html = "<span style='border-bottom: 2px dotted #ff0000;'>"
      html << label
      html << "</span>"
      return html.html_safe
    end      

    classes = ['tr8n_translatable']
    
    if translation_key.locked?
      classes << 'tr8n_locked'
    elsif language.default?
      classes << 'tr8n_not_translated'
    elsif options[:fallback] 
      classes << 'tr8n_fallback'
    else
      classes << (options[:translated] ? 'tr8n_translated' : 'tr8n_not_translated')
    end  

    # TODO: switch to <tml:label> notation
    html = "<span class='#{classes.join(' ')}' translation_key_id='#{translation_key.id}'>"
    html << label
    html << "</span>"
    html.html_safe
  end  

end