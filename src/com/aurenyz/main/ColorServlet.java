package com.aurenyz.main;

import java.io.IOException;
import java.io.OutputStream;
import java.net.Socket;
import java.net.UnknownHostException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ColorServlet
 */
public class ColorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    Socket ss=null;
    String baseip="192.168.4.";
    String baseip2="192.168.1.";
    String baseip4="192.168.88.";
    String baseip3="127.0.0.";
    int port=5000;
    String ipend="";
    String wholeip="";
    byte[] RGBMessage=null;
    byte[] LMessage=null;
    int r=0,g=0,b=0,light=0;
    int rl=0,gl=0,bl=0,lightl=0;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ColorServlet() {
        super();
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ipend=request.getParameter("ip");
		baseip=request.getRemoteAddr();
		System.out.println(baseip); 
		if(ipend==null||ipend==""||ipend.equals("null")){
			return;
		}
		baseip=baseip.substring(0,baseip.lastIndexOf('.')+1);
		System.out.println(baseip);
		r=Integer.parseInt(request.getParameter("r"));
		g=Integer.parseInt(request.getParameter("g"));
		b=Integer.parseInt(request.getParameter("b"));
		light=Integer.parseInt(request.getParameter("light"));
		
		
		createBaseMessage(r,g,b,light);
		wholeip=baseip+ipend;
		System.out.println("ip:"+wholeip+" r:"+r+" g:"+g+" b:"+b+" light:"+light);
		
		ss=null;
		if(ss==null){
				try {
					ss=createSocket(wholeip,port);
					OutputStream os=ss.getOutputStream();
					if(rl==r&&gl==g&&bl==b&&lightl==light){
						os.close();
						ss.close();
						return;
					}
					if(rl!=r||gl!=g||bl!=b){
						os.write(RGBMessage);
					}
					if(lightl!=light){
						os.write(LMessage);
					}
					os.close();
					ss.close();
				} catch (Exception e) {
					System.out.println("请检查此IP:"+wholeip+"的连接");
				}
		}
		rl=r;
		gl=g;
		bl=b;
		lightl=light;
	}
	
	public Socket createSocket(String ip,int port) throws Exception{
		return new Socket(ip,port);
	}
	
	public void createBaseMessage(int r,int g,int b,int light){
		RGBMessage=new byte[11];
		LMessage=new byte[10];
		RGBMessage[0]=(byte) 0xFA;
		RGBMessage[1]=0x0B;
		RGBMessage[2]=(byte) 0xF5;
		RGBMessage[3]=(byte) 0xF5;
		RGBMessage[4]=(byte) 0xC1;
		RGBMessage[5]=(byte) r;
		RGBMessage[6]=(byte) g;
		RGBMessage[7]=(byte) b;
		RGBMessage[8]=0x01;
		RGBMessage[9]=0x01;
		RGBMessage[10]=(byte) 0xFB;
		LMessage[0]=(byte) 0xFA;
		LMessage[1]=0x0A;
		LMessage[2]=(byte) 0xF5;
		LMessage[3]=(byte) 0xF5;
		LMessage[4]=(byte) 0xCF;
		LMessage[5]=(byte) light;
		LMessage[6]=0x01;
		LMessage[7]=0x01;
		LMessage[8]=0x00;
		LMessage[9]=(byte) 0xFB;
	}

}
