package com.mmm.ekwento

import org.springframework.web.servlet.support.RequestContextUtils as RCU;
import java.text.SimpleDateFormat;
import org.codehaus.groovy.grails.plugins.web.taglib.JavascriptValue;

class CustomTagLib {

	def checkBoxListReadOnly = {attrs, body ->
		
		def from = attrs.from
		def value = []
		if(attrs.value){
			value.addAll(attrs.value)
			value = value.collect{it.toString()}
		}

		def cname = attrs.name
		def isChecked, ht, wd, style, html

		//  sets the style to override height and/or width if either of them
		//  is specified, else the default from the CSS is taken
		style = "style='"
		if(attrs.height)
			style += "height:${attrs.height};"
		if(attrs.width)
			style += "width:${attrs.width};"

		if (style.length() == "style='".length())
			style = ""
		else
			style += "'" // closing single quote

		html = "<ul class='CheckBoxList' " + style + ">"

		out << html

		from.each { obj ->

			// if we wanted to select the checkbox using a click anywhere on the label (also hover effect)
			// but grails does not recognize index suffix in the name as an array:
			//      cname = "${attrs.name}[${idx++}]"
			//      and put this inside the li: <label for='$cname'>...</label>
			def myValue = obj."${attrs.optionKey}"
			isChecked = (value?.contains(myValue.toString()))? true: false
			out << "<li>"
			out << """
				<input type="checkbox" name="$cname" disabled="disabled" value="$myValue" id="$cname"
			"""
			if(isChecked)
				out << """
					checked="true"
				"""
			out << "/>"
			out << "${obj.toString()}"
			out << " </li>"
		}

		out << "</ul>"
	}

	
	def checkBoxList = {attrs, body ->

        def from = attrs.from
        def value = []
        if(attrs.value){
            value.addAll(attrs.value)
            value = value.collect{it.toString()}
        }

        def cname = attrs.name
        def isChecked, ht, wd, style, html

        //  sets the style to override height and/or width if either of them
        //  is specified, else the default from the CSS is taken
        style = "style='"
        if(attrs.height)
            style += "height:${attrs.height};"
        if(attrs.width)
            style += "width:${attrs.width};"

        if (style.length() == "style='".length())
            style = ""
        else
            style += "'" // closing single quote

        html = "<ul class='CheckBoxList' " + style + ">"

        out << html

        from.each { obj ->

            // if we wanted to select the checkbox using a click anywhere on the label (also hover effect)
            // but grails does not recognize index suffix in the name as an array:
            //      cname = "${attrs.name}[${idx++}]"
            //      and put this inside the li: <label for='$cname'>...</label>
            def myValue = obj."${attrs.optionKey}"
            isChecked = (value?.contains(myValue.toString()))? true: false
            out << "<li>"
            out << """
                <input type="checkbox" name="$cname" value="$myValue" id="$cname"
            """
            if(isChecked)
                out << """
                    checked="true"
                """
            out << "/>"
            out << "${obj.toString()}"
            out << " </li>"
        }

        out << "</ul>"

    }
	
	def jsdatePicker = { attrs ->
		def name = attrs['name']
		def bean = attrs['bean']
		def value
		def formatedValue = attrs['value']
		if (formatedValue == null)
			formatedValue = ''
		if(bean){
			value = bean[name]
			if(bean.hasErrors()){
			   formatedValue = params[name]
			}else{
				if(value)
					formatedValue = new SimpleDateFormat("MM/dd/yyyy").format(value)
			}
		}else
			value = attrs['value']
		out << """
            <input type="text" name="${name}" id="${name}" value="${formatedValue}" />
            <input type='button' value='...' id='${name}_trigger'>MM/DD/YYYY
            <script type='text/javascript'>
    			Calendar.setup(
    				{
    					inputField:'${name}',
    					button:'${name}_trigger',
                        daFormat:'%m/%d/%Y',
                        ifFormat:'%m/%d/%Y'
    				}
    			);
    		</script>
        """
	}
	
	def jscalender = { attrs ->
		def applicationUri = grailsAttributes.getApplicationUri(request)
			out << """
					<link rel="stylesheet" type="text/css" media="all" href="${applicationUri}/js/calendar/skins/aqua/theme.css" title="Aqua" />
					<script type='text/javascript' src='${applicationUri}/js/calendar/calendar.js'></script>
					<script type='text/javascript' src='${applicationUri}/js/calendar/calendar-setup.js'></script>
					<script type='text/javascript' src='${applicationUri}/js/calendar/lang/calendar-en.js'></script>

					  """
	}
	
	def isMenuSelected = {attrs,body ->
        def value = attrs.value
        if(pageProperty(name:'meta.menu') == value)
            out << ' selected'
    }

    def customRemoteField = { attrs, body ->
		def paramName = attrs.paramName ? attrs.remove('paramName') : 'value'
		def value = attrs.remove('value')
		def input_id = attrs.remove('input_id')
		def input_id_attribute = input_id?"id=\"${input_id}\"":""
		if (!value) value = ''
		out << "<input ${input_id_attribute} type=\"text\" name=\"${attrs.remove('name')}\" value=\"${value}\" onkeyup=\""

		if (attrs.params) {
			if (attrs.params instanceof Map) {
				attrs.params[paramName] = new JavascriptValue('this.value')
			}
			else {
				attrs.params += "+'${paramName}='+this.value"
			}
		}
		else {
			attrs.params = "'${paramName}='+this.value"
		}
		out << remoteFunction(attrs)
		attrs.remove('params')
		out << "\""
		attrs.remove('url')
		attrs.each { k,v->
			out << " $k=\"$v\""
		}
		out <<" />"
	}

	def dualList = { attrs, body ->
	    def name = attrs.remove('name')
	    def controller = attrs.remove('controller')
	    def params = attrs.params && attrs.params instanceof Map ? attrs.remove('params') : [:]
	    def update_available_list_action = attrs.remove('update_available_list_action')
	    def update_current_list_action = attrs.remove('update_current_list_action')
	    def add_action = attrs.remove('add_action')
	    def remove_action = attrs.remove('remove_action')
	    def available_list_id = "${name}_available_list"
	    def current_list_id = "${name}_current_list"

	    def map_for_available_list_filter = [
	        'input_id':"${available_list_id}_filter",
	        'name':"${available_list_id}_filter",
	        'controller':controller,
	        'action':update_available_list_action,
	        'update':"${available_list_id}_div",
	        'class':"customRemoteField"
	    ]
	    def map_for_current_list_filter = [
	        'input_id':"${current_list_id}_filter",
	        'name':"${current_list_id}_filter",
	        'controller':controller,
	        'action':update_current_list_action,
	        'update':"${current_list_id}_div",
	        'class':"customRemoteField"
	    ]
	    def map_for_update_available_script = [
	        'controller':controller,
	        'action':update_available_list_action,
	        'update':"${available_list_id}_div",
	        'params':"'value=' + filter + '&page='+page"
	    ]
	    def map_for_update_current_script = [
	        'controller':controller,
	        'action':update_current_list_action,
	        'update':"${current_list_id}_div",
	        'params':"'value=' + filter + '&page='+page"
	    ]
	    def map_for_remove_selected_script = [
	        'action':remove_action,
            'update':"${current_list_id}_div",
            'onSuccess':"${name}_updateAvailable()",
            'params':"'selected_id=' + selected + '&value=' + filter + '&page=' + page"
	    ]
	    def map_for_add_selected_script = [
	        'action':add_action,
            'update':"${current_list_id}_div",
            'onSuccess':"${name}_updateAvailable()",
            'params':"'selected_id=' + selected + '&value=' + filter + '&page=' + page"
	    ]

	    if(params.id){
    	    map_for_available_list_filter.id = params.id
    	    map_for_current_list_filter.id = params.id
    	    map_for_update_available_script.id = params.id
    	    map_for_update_current_script.id = params.id
    	    map_for_remove_selected_script.id = params.id
    	    map_for_add_selected_script.id = params.id
    	}
    	out << """
	        <script>
                function ${name}_updateAvailable(page){
                    var filter = \$('${name}_available_list_filter').value;
                    if(!page)
                        page = 1;
                    ${remoteFunction(map_for_update_available_script)}
                }
                function ${name}_updateCurrent(page){
                    var filter = \$('${name}_current_list_filter').value;
                    if(!page)
                        page = 1;
			        ${remoteFunction(map_for_update_current_script)}
			    }
                function ${name}_removeSelected(){
                    var list_id = '${current_list_id}'
                    var selected = \$F(list_id);
                    var page = \$(list_id+'_page').innerHTML;
                    if(selected){
                        var filter = \$('${current_list_id}_filter').value;
                        ${remoteFunction( map_for_remove_selected_script )}
                    }
                }
                function ${name}_addSelected(){
                    var list_id = '${available_list_id}'
	                var selected = \$F(list_id);
	                var page = \$(list_id+'_page').innerHTML;
	                if(selected){
		                var filter = \$('${current_list_id}_filter').value;
		                ${remoteFunction( map_for_add_selected_script )}
	                }
	            }
	            function select_all(select_id){
                    var options = \$\$('select#' + select_id +' option');
                    options.each(function(option){
                        option.selected = true;
                    });
                }
                function clearField(field_id){
                    var field = \$(field_id);
                    field.value = '';
                }
			</script>
		"""
	    out << "<table><tr>"
	    out << "<td><h3>Master List</h3></td><td></td><td><h3>Profiles</h3></td></tr>"
	    out << "<tr>"
	    out << "<td>"
	    out << customRemoteField(map_for_available_list_filter)
	    out << """&nbsp;<a href="clear" onclick="clearField('${available_list_id}_filter');${name}_updateAvailable(1);return false;">Clear</a>"""
        out << "<div id=\"${name}_available_list_div\">"
        out << "<script>${name}_updateAvailable(1)</script>"
        out << "</div>"
	    out << "</td>"
        out << "<td><br/></br><br/></br><br/></br><br/></br><br/></br><br/></br>"
        out << "<input type=\"button\" value=\"&lt;&lt;\" class=\"btn btn-primary\" onclick=\"${name}_removeSelected();\"/>"
        out << "<br/></br><br/></br>"
        out << "<input type=\"button\" value=\"&gt;&gt;\" class=\"btn btn-primary\" onclick=\"${name}_addSelected();\"/>"
        out << "</td>"
	    out << "<td>"
	    out << customRemoteField(map_for_current_list_filter)
	    out << """&nbsp;<a href="clear" onclick="clearField('${current_list_id}_filter');${name}_updateCurrent(1);return false;">Clear</a>"""
        out << "<div id=\"${name}_current_list_div\">"
        out << "<script>${name}_updateCurrent(1)</script>"
        out << "</div>"
	    out << "</td>"
	    out << "</tr></table>"
	}
}