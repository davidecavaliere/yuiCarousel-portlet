<%@page import="com.liferay.portal.kernel.util.MathUtil"%>
<%@page import="com.liferay.portal.service.ImageLocalServiceUtil"%>
<%@page import="com.liferay.portal.kernel.servlet.ImageServletTokenUtil"%>
<%@page import="com.liferay.portal.kernel.util.StringUtil"%>
<%@page import="com.liferay.portlet.PortletURLFactoryUtil"%>
<%@page import="com.liferay.portlet.imagegallery.service.IGImageLocalServiceUtil"%>
<%@page import="com.liferay.portlet.imagegallery.model.IGImage"%>
<%@page import="com.liferay.portal.theme.ThemeDisplay"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@page import="com.liferay.portlet.imagegallery.service.IGFolderLocalServiceUtil"%>
<%@page import="com.liferay.portlet.imagegallery.model.IGFolderConstants"%>
<%@page import="com.liferay.portal.kernel.util.GetterUtil"%>
<%@page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@page import="com.liferay.portlet.imagegallery.model.IGFolder"%>
<%@page import="com.liferay.portal.service.ImageServiceUtil"%>
<%@page import="com.liferay.portal.model.Image"%>
<%@include file="../init.jsp"%>

<portlet:defineObjects />
<liferay-theme:defineObjects/>


<%

int width = 950;
int height = 600;

%>
<style>

.layout {
	height: <%= height + 300 %>px;

}

.aui-carousel-item {
	background-color: rgba(0,0,0,1);
	width: <%= width %>px;
	height: <%= height %>px;
	text-align: center;
}



</style>

<%

long selectedFolderId = ParamUtil.getLong(request, "selectedFolderId",0);

PortletURL baseURL = PortletURLUtil.getCurrent(renderRequest, renderResponse);

long groupId = themeDisplay.getScopeGroupId();



List<IGFolder> folders = IGFolderLocalServiceUtil.getFolders(groupId);
IGFolder defaultFolder = null;
IGFolder selectedFolder = null;
if (folders.size()>0) {
	defaultFolder = folders.get(0);
	if (selectedFolderId != 0) {
		selectedFolder = IGFolderLocalServiceUtil.getFolder(selectedFolderId);
	} else {
		
		selectedFolder = defaultFolder;
		
	}
}


%>

<aui:layout cssClass="layout">
	<aui:column columnWidth="20" cssClass="menu">
		
		<c:if test="<%= folders.size()>0 %>">
			<h2>Selected Folder: <%= selectedFolder.getName() %></h2>
			<ul>
				<% for (IGFolder folder : folders) { %>
				<li>
					<%
						PortletURL url = PortletURLUtil.clone(baseURL, renderResponse);
						url.setParameter("selectedFolderId", StringUtil.valueOf(folder.getFolderId()));
					%>
					<aui:a href="<%=url.toString() %>"><%= folder.getName() %></aui:a>
				</li>
				<% } %>
			</ul>
		</c:if>
	</aui:column>
	<aui:column columnWidth="80" cssClass="slideshow">
		<%
	
	List<IGImage> images = IGImageLocalServiceUtil.getImages(groupId, selectedFolder.getFolderId());
	
	%>
	
	<h2><%= selectedFolder.getName() %></h2>
		
		
		<div id="carousel">
		<c:if test="<%= images.size()>0 %>">
		<% for (IGImage image : images) {
				Image img = ImageLocalServiceUtil.getImage(image.getLargeImageId());
				/* if (img.getWidth() > width)
					width = img.getWidth();
				if (img.getHeight() > height)
					height = img.getHeight(); */
				String imgURL = themeDisplay.getPathImage() + 
						"/image_gallery?img_id=" + image.getLargeImageId();
		%>
			<div class="aui-carousel-item">
				
				<%
					String size = "";
					String style = "";
					double w = new Integer(img.getWidth()).doubleValue();
					double h = new Integer(img.getHeight()).doubleValue();
					double ratio =  w/h; 
					if (img.getWidth() >= img.getHeight()) {
						if (img.getWidth() > width) {
							size = "width ='" + width +"' ";
						
						}
						Double newHeight = width * h / w;
						if (newHeight > height) {
							size = "height='" + height + "' ";
							
						} else {
							int margin = (height - newHeight.intValue())/2; 
							style = "style='margin: "+margin+"px auto' ";
						}
						/* size = "height='" + height +"' ";
						size += "width ='" + height * Math.round(ratio) + "' "; */
					} else {
						if (img.getHeight()>height) {
							size = "height='" + height +"' ";
						}
						double newWidth = w * height / h;
						if (newWidth > width) {
							size = "width='" + width + "' ";
						} 
						/* size = "width ='" + width +"' ";
						size += "height ='" + width/Math.round(ratio) + "' "; */
					}
				
				
				%>
				<a class="gallery-links" href="<%= imgURL %>">
					<img alt="" src="<%= imgURL %>" <%= size %> <%= style %>>
				</a>
				<div class="overlay">
					<span class="title"><%= image.getName() %></span> <br/>
					<span class="description"><%= image.getDescription() %></span> <br/>
					<span>orinal ratio = <%= ratio %> </span><br/>
					<span>new ratio = <%= Double.valueOf(width)/Double.valueOf(height) %></span><br/>
					<span>calc size = <%= size %></span><br/>
					<span>url = <%= imgURL %></span><br/>
					<span class="size"><%=StringUtil.valueOf( img.getWidth()) + " - " + StringUtil.valueOf(img.getHeight()) %></span>
				</div>
			</div>
			
			
		<% } %>
		</c:if>
		</div>
		
		
	</aui:column>
</aui:layout>


<%! 
public boolean isPortrait(Image img) {
	if (img.getWidth()<=img.getHeight())
		return true;
	else
		return false;
}

%>

<script>

AUI().ready('aui-carousel','aui-image-viewer', function(A) {

	console.log("entering");
	
	var viewportRegion = A.getDoc().get('viewportRegion');
	var maxHeight = (viewportRegion.height * 0.6);

	var maxWidth = (viewportRegion.width * 1.0);
	
	
	var component = new A.Carousel({
		intervalTime : 5,
		contentBox : '#carousel',
		activeIndex : 0,
	
		height : <%= height %>,
		width : <%= width %>,
	
	}).render();
	
	console.log(component);

	var imageGallery = new A.ImageGallery(
		{
			caption: '<%= selectedFolder.getName() %> - click to see full size',
			captionFromTitle: true,
			delay: 3000,
			links: '.gallery-links',
			maxHeight: maxHeight,
			maxWidth: maxWidth,
			showControls: false
		}
	).render();
	
	imageGallery.on('click', function(ev){
		/* console.log(this);
		console.log(imageGallery);
		console.log(imageGallery.getCurrentLink());
		 */
		window.open(imageGallery.getCurrentLink().getAttribute('href'),'_blank');
	});
	
	 component.on("click", function(ev){	
		component.pause();
	}); 
});

</script>