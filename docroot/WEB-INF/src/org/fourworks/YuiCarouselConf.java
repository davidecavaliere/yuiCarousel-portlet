package org.fourworks;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.liferay.portal.kernel.portlet.ConfigurationAction;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portlet.PortletPreferencesFactoryUtil;

public class YuiCarouselConf implements ConfigurationAction {

	private static final String confPage = "/html/yuicarousel/config.jsp";
	
	@Override
	public void processAction(PortletConfig portletConfig,
			ActionRequest actionRequest, ActionResponse actionResponse)
			throws Exception {
		String portletResource = ParamUtil.getString(actionRequest,	"portletResource");

		PortletPreferences pref = PortletPreferencesFactoryUtil.getPortletSetup(actionRequest, portletResource);

		String width = actionRequest.getParameter("width");
		String height = actionRequest.getParameter("height");

		String bgColor = actionRequest.getParameter("background");

		pref.setValue("width", width);
		pref.setValue("height", height);
		pref.setValue("bg-color", bgColor);

		pref.store();
		
		SessionMessages.add(actionRequest, portletConfig.getPortletName()
				+ ".doConfigure");

	}

	@Override
	public String render(PortletConfig portletConfig,
			RenderRequest renderRequest, RenderResponse renderResponse)
			throws Exception {
		String contextPath = renderRequest.getContextPath();
		return contextPath +  confPage;
	}

}
