package org.fourworks;

import java.io.IOException;

import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.liferay.util.bridges.mvc.MVCPortlet;

/**
 * Portlet implementation class YuiCarouselPortlet
 */
public class YuiCarouselPortlet extends MVCPortlet {
 
	@Override
	public void doConfig(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		
		//super.doConfig(renderRequest, renderResponse);
		
		include("/html/yuicarousel/config.jsp", renderRequest, renderResponse);
	}
	
	@Override
	public void doEdit(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		
//		super.doEdit(renderRequest, renderResponse);
		include("/html/yuicarousel/edit.jsp", renderRequest, renderResponse);
	}

	@Override
	public void doAbout(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		super.doAbout(renderRequest, renderResponse);
	}
	
}
