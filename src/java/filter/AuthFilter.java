package filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // TODO: Initialize filter
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // TODO: Implement authentication logic
        // Check if user is logged in
        // If not logged in, redirect to login page
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // TODO: Cleanup filter
    }
}
