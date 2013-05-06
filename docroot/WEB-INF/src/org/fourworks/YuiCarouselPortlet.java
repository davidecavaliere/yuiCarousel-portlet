package org.fourworks;

import java.io.IOException;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portlet.PortletPreferencesFactoryUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

/**
 * Portlet implementation class YuiCarouselPortlet
 */
public class YuiCarouselPortlet extends MVCPortlet {

	@Override
	public void doConfig(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {

		// super.doConfig(renderRequest, renderResponse);

		include("/html/yuicarousel/config.jsp", renderRequest, renderResponse);
	}

	@Override
	public void doEdit(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {

		// super.doEdit(renderRequest, renderResponse);
		include("/html/yuicarousel/edit.jsp", renderRequest, renderResponse);
	}

	@Override
	public void doAbout(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		super.doAbout(renderRequest, renderResponse);
	}

	public void savePreferences(ActionRequest aRequest, ActionResponse aResponse)
			throws SystemException, IOException, PortletException {
		javax.portlet.PortletPreferences pref = PortletPreferencesFactoryUtil
				.getPortletSetup(aRequest);

		String width = aRequest.getParameter("width");
		String height = aRequest.getParameter("height");

		String bgColor = aRequest.getParameter("background");

		pref.setValue("width", width);
		pref.setValue("height", height);
		pref.setValue("bg-color", bgColor);

		pref.store();
		
		include("/html/yuicarousel/view.jsp", aRequest, aResponse);
	}

}
