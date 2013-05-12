<%@page import="com.liferay.portlet.PortletPreferencesFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.util.Validator"%>
<%@include file="../init.jsp"%>

<portlet:defineObjects />
<liferay-theme:defineObjects/>


<%

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	  portletPreferences = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource);
}

String wString = portletPreferences.getValue("width", "950");
String hString = portletPreferences.getValue("height", "600");

String bgColor = portletPreferences.getValue("bg-color", "FFF");

%>
<style>
#bg-color {	
	border: 1px solid;
    box-shadow: 1px 1px 1px;
    height: 50px;
    margin: 5px;
    width: 50px;
	background-color: #<%=bgColor%>; 
}

</style>


<liferay-portlet:actionURL portletConfiguration="true" var="savePreferencesURL"/>


<liferay-ui:header title="Yui Carousel Preferences"/>
<aui:layout>
	<aui:form action="<%= savePreferencesURL.toString() %>" name="PREFFM" method="POST">
		<aui:fieldset label="Size">
			<aui:input name="width" value="<%= wString %>"></aui:input>
			<aui:input name="height" value="<%= hString %>"></aui:input>
		
		</aui:fieldset>
		
		<aui:fieldset label="Colours" >
			<aui:legend label="background-color"></aui:legend>
			<table>
				<tr>
					<td>
						<div id="bg-color"></div>
					</td>
					<td>
					<td>
						<div id="color-button"></div>
					</td>
				</tr>
			</table>
			<aui:input name="background" value="<%= bgColor %>"></aui:input>
		</aui:fieldset>
		<aui:button-row>
			<aui:button type="submit" value="save"/>
		</aui:button-row>
	</aui:form>
</aui:layout>

<aui:script use="aui-color-picker">
var backgroundTextValue = A.one('#<portlet:namespace/>background');
var inputBox = A.one('#bg-color');
console.log(inputBox);
var colorPicker2 = new A.ColorPicker({
	before: {
		
		
	},
	after: {
		colorChange: function(event) {
			inputBox.setStyle('background','#'+this.get('hex')); // Update an input field with the hex value
			backgroundTextValue.val(this.get('hex'));
		}
	},
	boundingBox: '#color-button'
}).render();

console.log(colorPicker2);

</aui:script>
