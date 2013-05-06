<%@include file="../init.jsp"%>

<portlet:defineObjects />
<liferay-theme:defineObjects/>

<%
String wString = portletPreferences.getValue("width", "950");
String hString = portletPreferences.getValue("height", "600");

String bgColor = portletPreferences.getValue("bg-color", "FFF");

%>
<liferay-portlet:actionURL name="savePreferences" var="savePreferencesURL"/>


<liferay-ui:header title="Yui Carousel Preferences"/>
<aui:layout>
	<aui:form action="<%= savePreferencesURL.toString() %>" name="PREFFM" method="POST">
		<aui:fieldset label="Size">
			<aui:input name="width" value="<%= wString %>"></aui:input>
			<aui:input name="height" value="<%= hString %>"></aui:input>
		
		</aui:fieldset>
		
		<aui:fieldset label="Colours" >
			
			<aui:input id="background-color" name="background" value="<%= bgColor %>"/><span id="bg-color-picker"></span>
			
		</aui:fieldset>
		<aui:button-row>
			<aui:button type="submit" value="save"/>
		</aui:button-row>
	</aui:form>
</aui:layout>

<aui:script use="aui-color-picker">
console.log(A);
var inputBox = A.one('#<portlet:namespace/>background-color');
console.log(inputBox);

var colorPicker2 = new A.ColorPicker({
	contentBox: '#bg-color-picker',
	after: {
		colorChange: function(event) {
			inputBox.val(this.get('hex')); // Update an input field with the hex value
		}
	}
}).render();
</aui:script>
