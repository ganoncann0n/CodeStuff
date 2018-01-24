package screens;

import game.Human;


import game.Orientation;
import java.awt.CardLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.*;

import SpaceShips.*;


public class ShipSelect extends JPanel{

	//fields
	public JPanel contentPanel;
	
	public FieldScreen fieldScreen;
	
	public JButton startGame, backButton;
	
	public BufferedImage battlecruiserSheet, carrierSheet, frigateSheet, 
				  battlecruiserHoriz, battlecruiserVert, carrierHoriz, carrierVert, frigateHoriz, frigateVert,
				  inteceptorHoriz, inteceptorVert;
	public BufferedImage battlecruiserSheetBW, battlecruiserBW, battlecruiserBWV, inteceptorBW, inteceptorBWV, carrierBW, carrierBWV, frigateBW, frigateBWV;
	public BufferedImage battlecruiserOut, battlecruiserOutV, battlecruiserOutSheet, inteceptorOut, inteceptorOutV, carrierOut, carrierOutV, frigateOut, frigateOutV;
	public BufferedImage space, grid, fleetBay;
	public BufferedImage carrierHInfo, carrierVInfo, battlecruiserHInfo, battlecruiserVInfo, frigateHInfo, frigateVInfo, inteceptorHInfo, inteceptorVInfo;
	
	public boolean battlecruiserSelected, carrierSelected, frigateSelected, inteceptorSelected;
	public boolean onGrid = false;
	public boolean valid = false;
	public boolean mouseHold = false;
	
	public int x, y;
	
	public int battlecruisers, carriers, frigates, inteceptors = 0;
	
	public Vessel battlecruiser, carrier, frigate, inteceptor;
	public Vessel c1, bc1, bc2, f1, f2, f3, i1, i2, i3, i4;
	
	public Vessel mouseHoldingExact;
	public Vessel mouseHolding;
	
	public Human p;	

	public static int CELL = 65;
	public static int GRID_X = 300;
	public static int GRID_Y = 17;
	
	//constructor
	public ShipSelect(JPanel contentPanel) {
		this.contentPanel = contentPanel;
		
		p = new Human();
		battlecruiser = new BattleCruiser();
		carrier = new Carrier();
		frigate = new Frigate();
		inteceptor = new Inteceptor();
		
		c1 = new Carrier();
		bc1 = new BattleCruiser();
		bc2 = new BattleCruiser();
		f1 = new Frigate();
		f2 = new Frigate();
		f3 = new Frigate();
		i1 = new Inteceptor();
		i2 = new Inteceptor();
		i3 = new Inteceptor();
		i4 = new Inteceptor();
		
		mouseHold = false;
		mouseHolding = null;
		mouseHoldingExact = null;
		
		loadImages();
		layoutPanel();
		createListeners();
	}

	//create the listeners
	private void createListeners() {
		this.addMouseMotionListener(new HighlightVessel());
		this.addMouseListener(new SelectVessel());
		backButton.addActionListener(new BackToMain());
		startGame.addActionListener(new PlayGame());
	}
	
	//mouse mover listener
	private class HighlightVessel implements MouseMotionListener{
		public void mouseDragged(MouseEvent e){
			//n/a
		}
		
		//hovering mouse over a vessel will highlight it and display its information
		public void mouseMoved(MouseEvent e){
			battlecruiserSelected = false;
			carrierSelected = false;
			inteceptorSelected = false;
			frigateSelected = false;
			onGrid = false;

			
			x = e.getX();
			y = e.getY();
			
			if((x >= 300) && (x <= 950) && (y >= 17) && (y <= 667)){
				onGrid = true;
			}
			if((x >= 1140) && (x <= 1225) && (y >= 90) && (y <= 160) && (battlecruisers < 2)){
				battlecruiserSelected = true;
			}
			if((x >= 1140) && (x <= 1200) && (y >= 210) && (y <= 274) && (inteceptors < 4)){
				inteceptorSelected = true;
			}
			if((x >= 1140) && (x <= 1238) && (y >= 455) && (y <= 485) && (carriers < 1)){
				carrierSelected = true;
			}
			if((x >= 1145) && (x <= 1235) && (y >= 330) && (y <= 390) && (frigates < 3)){
				frigateSelected = true;
			}

			repaint();
		}
	}
	
	//mouse clicker listener
	private class SelectVessel implements MouseListener{
		public void mouseClicked(MouseEvent e){
			x = e.getX();
			y = e.getY();

			//left click
			if(e.getButton() == 1){
				
				//attaching to mouse
				if(!mouseHold){
				
					//on battlcruiser
					if((x >= 1140) && (x <= 1225) && (y >= 90) && (y <= 160) && (battlecruisers < 2)){
						if(battlecruisers < 1){
							mouseHold = true;
							mouseHolding = battlecruiser;
							mouseHoldingExact = bc1;
							repaint();
						}
						else if(battlecruisers == 1){
							mouseHold = true;
							mouseHolding = battlecruiser;
							mouseHoldingExact = bc2;
							repaint();
						}
					}
				
					//on interceptor
					else if((x >= 1140) && (x <= 1200) && (y >= 210) && (y <= 274) && (inteceptors < 4)){
						if(inteceptors < 1){
							mouseHold = true;
							mouseHolding = inteceptor;
							mouseHoldingExact = i1;
							repaint();
						}
						else if(inteceptors == 1){
							mouseHold = true;
							mouseHolding = inteceptor;
							mouseHoldingExact = i2;
							repaint();
						}
						else if(inteceptors == 2){
							mouseHold = true;
							mouseHolding = inteceptor;
							mouseHoldingExact = i3;
							repaint();
						}
						else if(inteceptors == 3){
							mouseHold = true;
							mouseHolding = inteceptor;
							mouseHoldingExact = i4;
							repaint();
						}
					}
				
					//on frigate
					else if((x >= 1145) && (x <= 1235) && (y >= 330) && (y <= 390) && (frigates < 3)){
						if(frigates < 1){
							mouseHold = true;
							mouseHolding = frigate;
							mouseHoldingExact = f1;
							repaint();
						}
						else if(frigates == 1){
							mouseHold = true;
							mouseHolding = frigate;
							mouseHoldingExact = f2;
							repaint();
						}
						else if(frigates == 2){
							mouseHold = true;
							mouseHolding = frigate;
							mouseHoldingExact = f3;
							repaint();
						}
					}
				
					//on carrier
					else if((x >= 1140) && (x <= 1238) && (y >= 455) && (y <= 485) && (carriers < 1)){
						mouseHold = true;
						mouseHolding = carrier;
						mouseHoldingExact = c1;
						repaint();
					}
				}
				
				//placing on board 
				else if(mouseHold){
					
					if(onGrid){
						//check the which box it is in
						for(int i = 0; i < 10; i++){
							for(int k = 0; k < 10; k++){
								if((x >= GRID_X+(i*CELL)) && (x < GRID_X+((i+1)*CELL)) && (y >= GRID_Y+(k*CELL)) && (y < GRID_Y+((k+1)*CELL))){
									//check if it is a valid location
									//System.out.println("[" + k + "]" + "[" + i + "]");
									mouseHoldingExact.setStartX(k);
									mouseHoldingExact.setStartY(i);
									valid = p.isEmpty(mouseHoldingExact);
									
									//add to player's board of valid, reset mouse holder, increment vessel tracker
									if(valid){
										//System.out.println("valid");
										p.addVessel(mouseHoldingExact);
										mouseHoldingExact.setOnGrid(true);
										
										mouseHold = false;
										battlecruiser.setDirection(Orientation.HORIZONTAL);
										carrier.setDirection(Orientation.HORIZONTAL);
										frigate.setDirection(Orientation.HORIZONTAL);
										inteceptor.setDirection(Orientation.HORIZONTAL);
										
										if(mouseHolding == carrier){
											carriers++;
											mouseHolding = null;
											mouseHoldingExact = null;
											repaint();
										}
										else if(mouseHolding == battlecruiser){
											battlecruisers++;
											mouseHolding = null;
											mouseHoldingExact = null;
											repaint();

										}
										else if(mouseHolding == frigate){
											frigates++;
											mouseHolding = null;
											mouseHoldingExact = null;
											repaint();

										}
										else if(mouseHolding == inteceptor){
											inteceptors++;
											mouseHolding = null;
											mouseHoldingExact = null;
											repaint();
											

										}	
									}
									else if(!valid){
										System.out.println("not valid");
									}
								}
							}
						}
					}
				}
			}
			
			//right click
			else{
				if(mouseHold){
					
					//battlecruiser
					if((battlecruisers < 1) && (mouseHolding == battlecruiser)){
						if(bc1.getDirection() == Orientation.HORIZONTAL){
							bc1.setDirection(Orientation.VERTICAL);
							battlecruiser.setDirection(Orientation.VERTICAL);
							repaint();
						}
						else{
							bc1.setDirection(Orientation.HORIZONTAL);
							battlecruiser.setDirection(Orientation.HORIZONTAL);
							repaint();
						}
					}
					else if((battlecruisers == 1) && (mouseHolding == battlecruiser)){
						if(bc2.getDirection() == Orientation.HORIZONTAL){
							bc2.setDirection(Orientation.VERTICAL);
							battlecruiser.setDirection(Orientation.VERTICAL);
							repaint();
						}
						else{
							bc2.setDirection(Orientation.HORIZONTAL);
							battlecruiser.setDirection(Orientation.HORIZONTAL);
							repaint();
						}
					}
					
					//inteceptors
					else if((inteceptors < 1) && (mouseHolding == inteceptor)){
						if(i1.getDirection() == Orientation.HORIZONTAL){
							i1.setDirection(Orientation.VERTICAL);
							inteceptor.setDirection(Orientation.VERTICAL);
							repaint();
						}
						else{
							i1.setDirection(Orientation.HORIZONTAL);
							inteceptor.setDirection(Orientation.HORIZONTAL);
							repaint();
						}
					}
					else if((inteceptors == 1) && (mouseHolding == inteceptor)){
						if(i2.getDirection() == Orientation.HORIZONTAL){
							i2.setDirection(Orientation.VERTICAL);
							inteceptor.setDirection(Orientation.VERTICAL);
							repaint();
						}
						else{
							i2.setDirection(Orientation.HORIZONTAL);
							inteceptor.setDirection(Orientation.HORIZONTAL);
							repaint();
						}
					}
					else if((inteceptors == 2) && (mouseHolding == inteceptor)){
						if(i3.getDirection() == Orientation.HORIZONTAL){
							i3.setDirection(Orientation.VERTICAL);
							inteceptor.setDirection(Orientation.VERTICAL);
							repaint();
						}
						else{
							i3.setDirection(Orientation.HORIZONTAL);
							inteceptor.setDirection(Orientation.HORIZONTAL);
							repaint();
						}
					}
					else if((inteceptors == 3) && (mouseHolding == inteceptor)){
						if(i4.getDirection() == Orientation.HORIZONTAL){
							i4.setDirection(Orientation.VERTICAL);
							inteceptor.setDirection(Orientation.VERTICAL);
							repaint();
						}
						else{
							i4.setDirection(Orientation.HORIZONTAL);
							inteceptor.setDirection(Orientation.HORIZONTAL);
							repaint();
						}
					}
					
					//frigates
					else if((frigates < 1) && (mouseHolding == frigate)){
						if(f1.getDirection() == Orientation.HORIZONTAL){
							f1.setDirection(Orientation.VERTICAL);
							frigate.setDirection(Orientation.VERTICAL);
							repaint();
						}
						else{
							f1.setDirection(Orientation.HORIZONTAL);
							frigate.setDirection(Orientation.HORIZONTAL);
							repaint();
						}
					}
					else if((frigates == 1) && (mouseHolding == frigate)){
						if(f2.getDirection() == Orientation.HORIZONTAL){
							f2.setDirection(Orientation.VERTICAL);
							frigate.setDirection(Orientation.VERTICAL);
							repaint();
						}
						else{
							f2.setDirection(Orientation.HORIZONTAL);
							frigate.setDirection(Orientation.HORIZONTAL);
							repaint();
						}
					}
					else if((frigates == 2) && (mouseHolding == frigate)){
						if(f3.getDirection() == Orientation.HORIZONTAL){
							f3.setDirection(Orientation.VERTICAL);
							frigate.setDirection(Orientation.VERTICAL);
							repaint();
						}
						else{
							f3.setDirection(Orientation.HORIZONTAL);
							frigate.setDirection(Orientation.HORIZONTAL);
							repaint();
						}
					}
					
					//carrier
					else if((carriers < 1) && (mouseHolding == carrier)){
						if(c1.getDirection() == Orientation.HORIZONTAL){
							c1.setDirection(Orientation.VERTICAL);
							carrier.setDirection(Orientation.VERTICAL);
							repaint();
						}
						else{
							c1.setDirection(Orientation.HORIZONTAL);
							carrier.setDirection(Orientation.HORIZONTAL);
							repaint();
						}
					}
				}
			}
		}
		
		public void mouseEntered(MouseEvent e){
			//not used
		}
		
		public void mouseExited(MouseEvent e){
			//not used
		}
		
		public void mousePressed(MouseEvent e){
			//not used
		}
		
		public void mouseReleased(MouseEvent e){
			//not used
		}
	}
	
	private class BackToMain implements ActionListener{
		public void actionPerformed(ActionEvent e){
			CardLayout cardLayout = (CardLayout) contentPanel.getLayout();
			cardLayout.show(contentPanel, "mainMenu");
		}
	}
	
	private class PlayGame implements ActionListener{
		public void actionPerformed(ActionEvent e){
			if((carriers == 1) && (battlecruisers == 2) && (frigates == 3) && (inteceptors == 4)){
				startGame.setEnabled(true);
				fieldScreen = new FieldScreen(contentPanel, p);
				contentPanel.add(fieldScreen, "fieldScreen");
				CardLayout cardLayout = (CardLayout) contentPanel.getLayout();
				cardLayout.show(contentPanel, "fieldScreen");
			}
			else
				startGame.setEnabled(false);
		}
	}

	private void layoutPanel() {
		setLayout(null);
		
		startGame = new JButton("Ready for Battle!");
		backButton = new JButton("Back");
		
		startGame.setSize(new Dimension(150, 60));
		backButton.setSize(new Dimension(150, 60));
		
		startGame.setLocation(20, 100);
		backButton.setLocation(20, 180);
		
		startGame.setEnabled(false);
		
		add(startGame);
		add(backButton);
		
	}

	//load image data
	private void loadImages() {
		
		try{
			//load sheets
			space = ImageIO.read(new File("images" + File.separator + "space.png"));
			grid = ImageIO.read(new File("images" + File.separator + "grid.png"));
			fleetBay = ImageIO.read(new File("images" + File.separator + "fleetBay.png"));
			battlecruiserSheet = ImageIO.read(new File("images" + File.separator + "battlecruiser.png"));
			battlecruiserSheetBW = ImageIO.read(new File("images" + File.separator + "battlecruiserBW.png"));
			battlecruiserOutSheet = ImageIO.read(new File("images" + File.separator + "battlecruiserOut.png"));
			
			//load battlecruiser subimages
			battlecruiserHoriz = battlecruiserSheet.getSubimage(15, 160, 95, 70);
			battlecruiserVert = battlecruiserSheet.getSubimage(13, 0, 85, 70);
			battlecruiserBW = battlecruiserSheetBW.getSubimage(15, 160, 95, 70);
			battlecruiserBWV = ImageIO.read(new File("images" + File.separator + "battlecruiserBWV.png"));
			battlecruiserOutV = ImageIO.read(new File("images" + File.separator + "battlecruiserVOut.png"));
			battlecruiserOut = battlecruiserOutSheet.getSubimage(15, 160, 95, 70);
			battlecruiserHInfo = ImageIO.read(new File("images" + File.separator + "battlecruiserInfo.png"));
			
			//load carrier subimages
			carrierHoriz = ImageIO.read(new File("images" + File.separator + "carrierH.png"));
			carrierVert = ImageIO.read(new File("images" + File.separator + "carrierV.png"));
			carrierBW = ImageIO.read(new File("images" + File.separator + "carrierBW.png"));
			carrierBWV = ImageIO.read(new File("images" + File.separator + "carrierBWV.png"));
			carrierOut = ImageIO.read(new File("images" + File.separator + "carrierOut.png"));
			carrierOutV = ImageIO.read(new File("images" + File.separator + "carrierOutV.png"));
			carrierHInfo = ImageIO.read(new File("images" + File.separator + "carrierInfo.png"));
			
			//load frigate subimages
			frigateHoriz = ImageIO.read(new File("images" + File.separator + "frigateH.png"));
			frigateVert = ImageIO.read(new File("images" + File.separator + "frigateV.png"));
			frigateBW = ImageIO.read(new File("images" + File.separator + "frigateBW.png"));
			frigateBWV = ImageIO.read(new File("images" + File.separator + "frigateBWV.png"));
			frigateOut = ImageIO.read(new File("images" + File.separator + "frigateSelected.png"));
			frigateOutV = ImageIO.read(new File("images" + File.separator + "frigateOutV.png"));
			frigateHInfo = ImageIO.read(new File("images" + File.separator + "frigateInfo.png"));
			
			
			//load interceptor subimages
			inteceptorHoriz = ImageIO.read(new File("images" + File.separator + "interceptorH.png"));
			inteceptorVert = ImageIO.read(new File("images" + File.separator + "interceptorV.png"));
			inteceptorOut = ImageIO.read(new File("images" + File.separator + "interceptorHout.png"));
			inteceptorOutV = ImageIO.read(new File("images" + File.separator + "inteceptorOutV.png"));
			inteceptorBW = ImageIO.read(new File("images" + File.separator + "inteceptorBW.png"));
			inteceptorBWV = ImageIO.read(new File("images" + File.separator + "inteceptorBWV.png"));
			inteceptorHInfo = ImageIO.read(new File("images" + File.separator + "inteceptorInfo.png"));
			
			
		}catch(IOException e){
			System.out.println("Could not load vessel images");
		}
		
	}
	
	//draw
	public void paintComponent(Graphics g){
		//draw background images
		g.drawImage(space, 0, 0, null);
		g.drawImage(grid, 300, 17, null);

		
		//draw ship dock
		g.setColor(Color.BLACK);
		g.drawRect(1110, 10, 155, 600);
		g.setColor(Color.LIGHT_GRAY);
		g.fillRoundRect(1110, 10, 154, 599, 10, 10);
		g.drawImage(fleetBay, 1135, 25, null);

		
		//draw base ships
		g.setColor(Color.BLACK);
	
		g.drawImage(battlecruiserHoriz, 1140, 90, null);
		g.drawString("X " + (2 - battlecruisers), 1180, 180);
		
		g.drawImage(inteceptorHoriz, 1140, 210, null);
		g.drawString("X " + (4 - inteceptors), 1180, 294);
		
		g.drawImage(frigateHoriz, 1140, 310, null);
		g.drawString("X " + (3 - frigates), 1180, 410);
		
		g.drawImage(carrierHoriz, 1140, 420, null);
		g.drawString("X " + (1 - carriers), 1180, 505);
		
		//fleetBay tracker
		if(carriers == 1){
			g.drawImage(carrierBW, 1140, 420, null);
		}
		
		if(battlecruisers == 2){
			g.drawImage(battlecruiserBW, 1140, 90, null);
		}
		
		if(frigates == 3){
			g.drawImage(frigateBW, 1140, 310, null);
		}
		
		if(inteceptors == 4){
			g.drawImage(inteceptorBW, 1140, 210, null);
		}
		
		if((carriers == 1) && (battlecruisers == 2) && (frigates == 3) && (inteceptors == 4)){
			startGame.setEnabled(true);
			g.setColor(Color.WHITE);
			g.drawString("Fleet complete!", 20, 610);
		}
		
		if((carriers != 1) || (battlecruisers != 2) || (frigates != 3) || (inteceptors != 4)){
			g.setColor(Color.RED);
			g.drawString(" 	Finish building your fleet first", 20, 80);
		}
		
		//highlighting
		if(battlecruiserSelected){
			g.drawImage(battlecruiserOut, 1140, 90, null);
			//display battlecruiser info
			g.drawImage(battlecruiserHInfo, (int)(x - 250), (int)(y), null);
		}
		if(inteceptorSelected){
			g.drawImage(inteceptorOut, 1140, 210, null);
			//display inteceptor info
			g.drawImage(inteceptorHInfo, (int)(x - 250), (int)(y), null);
		}
		if(frigateSelected){
			g.drawImage(frigateOut, 1140, 310, null);
			//display battlecruiser info
			g.drawImage(frigateHInfo, (int)(x - 250), (int)(y), null);

		}
		if(carrierSelected){
			g.drawImage(carrierOut, 1140, 420, null);
			//display carrier info
			g.drawImage(carrierHInfo, (int)(x - 250), (int)(y), null);

		}
		
		//ship count HUD
		if(carriers < 1){
			g.setColor(Color.WHITE);
			g.drawString("1 Carrier remaining, 0 placed", 20, 610);
		}
		
		if(battlecruisers < 2){
			g.setColor(Color.WHITE);
			g.drawString((2-battlecruisers) + " Battle Cruisers remaining, " + battlecruisers + " placed", 20, 630);
		}
		
		if(frigates < 3){
			g.setColor(Color.WHITE);
			g.drawString((3-frigates) + " Frigates remaining, " + frigates + " placed", 20, 650);
		}
		
		if(inteceptors < 4){
			g.setColor(Color.WHITE);
			g.drawString((4-inteceptors) + " Interceptors remaining, " + inteceptors + " placed", 20, 670);
		}
		
		//unit placer (mouse)
		if(mouseHold){
			if(mouseHolding == battlecruiser){
				if(battlecruiser.getDirection() == Orientation.HORIZONTAL)
					g.drawImage(battlecruiserHoriz.getScaledInstance(57, 47, 0), (int)(x - 25), (int)(y - 23), null);
				else
					g.drawImage(battlecruiserVert.getScaledInstance(57, 47, 0), (int)(x - 32), (int)(y - 23), null);
			}
			else if(mouseHolding == carrier){
				if(carrier.getDirection() == Orientation.HORIZONTAL)
					g.drawImage(carrierHoriz.getScaledInstance(65, 65, 0), (int)(x - 32), (int)(y - 32), null);
				else
					g.drawImage(carrierVert.getScaledInstance(65, 65, 0), (int)(x - 32), (int)(y - 32), null);
			}
			else if(mouseHolding == frigate){
				if(frigate.getDirection() == Orientation.HORIZONTAL)
					g.drawImage(frigateHoriz.getScaledInstance(60, 40, 0), (int)(x - 30), (int)(y - 20), null);
				else
					g.drawImage(frigateVert.getScaledInstance(60, 40, 0), (int)(x - 30), (int)(y - 20), null);
			}	
			else{
				if(inteceptor.getDirection() == Orientation.HORIZONTAL)
					g.drawImage(inteceptorHoriz.getScaledInstance(40, 43, 0), (int)(x - 18), (int)(y - 19), null);
				else
					g.drawImage(inteceptorVert.getScaledInstance(40, 43, 0), (int)(x - 20), (int)(y - 24), null);
			}
		}
		
		//unit placer (grid tracker)
		if((onGrid) && (mouseHold)){
			
			for(int i = 0; i < 10; i++){
				for(int k = 0; k < 10; k++){
					if((x >= GRID_X+(i*CELL)) && (x < GRID_X+((i+1)*CELL)) && (y >= GRID_Y+(k*CELL)) && (y < GRID_Y+((k+1)*CELL))){
						mouseHoldingExact.setStartX(k);
						mouseHoldingExact.setStartY(i);
						valid = p.isEmpty(mouseHoldingExact);
					}			
				}		
			
			}
			
			//draw valid ship placement
			if(valid){
				if(mouseHolding == carrier){
					if(carrier.getDirection() == Orientation.HORIZONTAL){
						g.drawImage(carrierOut.getScaledInstance(65, 65, 0), (int)(x + 33), (int)(y - 32), null);
						g.drawImage(carrierOut.getScaledInstance(65, 65, 0), (int)(x + 98), (int)(y - 32), null);
						g.drawImage(carrierOut.getScaledInstance(65, 65, 0), (int)(x + 163), (int)(y - 32), null);
						g.drawImage(carrierOut.getScaledInstance(65, 65, 0), (int)(x + 228), (int)(y - 32), null);
						g.drawImage(carrierOut.getScaledInstance(65, 65, 0), (int)(x + 293), (int)(y - 32), null);

					}
					else{
						g.drawImage(carrierOutV.getScaledInstance(65, 65, 0), (int)(x - 32), (int)(y + 33), null);
						g.drawImage(carrierOutV.getScaledInstance(65, 65, 0), (int)(x - 32), (int)(y + 98), null);
						g.drawImage(carrierOutV.getScaledInstance(65, 65, 0), (int)(x - 32), (int)(y + 163), null);
						g.drawImage(carrierOutV.getScaledInstance(65, 65, 0), (int)(x - 32), (int)(y + 228), null);
						g.drawImage(carrierOutV.getScaledInstance(65, 65, 0), (int)(x - 32), (int)(y + 293), null);

					}
				}
				else if(mouseHolding == battlecruiser){
					if(battlecruiser.getDirection() == Orientation.HORIZONTAL){
						g.drawImage(battlecruiserOut.getScaledInstance(57, 47, 0), (int)(x + 33 + 8), (int)(y - 32 + 8), null);
						g.drawImage(battlecruiserOut.getScaledInstance(57, 47, 0), (int)(x + 98 + 8), (int)(y - 32 + 8), null);
						g.drawImage(battlecruiserOut.getScaledInstance(57, 47, 0), (int)(x + 163 + 8), (int)(y - 32 + 8), null);
					}
					else{
						g.drawImage(battlecruiserOutV.getScaledInstance(57, 47, 0), (int)(x - 35), (int)(y + 33 + 8), null);
						g.drawImage(battlecruiserOutV.getScaledInstance(57, 47, 0), (int)(x - 35), (int)(y + 98 + 8), null);
						g.drawImage(battlecruiserOutV.getScaledInstance(57, 47, 0), (int)(x - 35), (int)(y + 163 + 8), null);
					}
				}
				else if(mouseHolding == frigate){
					if(frigate.getDirection() == Orientation.HORIZONTAL){
						g.drawImage(frigateOut.getScaledInstance(60, 40, 0), (int)(x + 33), (int)(y - 32 + 11), null);
						g.drawImage(frigateOut.getScaledInstance(60, 40, 0), (int)(x + 98), (int)(y - 32 + 11), null);
					}
					else{
						g.drawImage(frigateOutV.getScaledInstance(60, 40, 0), (int)(x - 32 + 3), (int)(y + 33 + 4), null);
						g.drawImage(frigateOutV.getScaledInstance(60, 40, 0), (int)(x - 32 + 3), (int)(y + 98 + 4), null);
					}
				}
				else if(mouseHolding == inteceptor){
					if(inteceptor.getDirection() == Orientation.HORIZONTAL){
						g.drawImage(inteceptorOut.getScaledInstance(40, 43, 0), (int)(x + 33 + 10), (int)(y - 32 + 12), null);
					}
					else{
						g.drawImage(inteceptorOutV.getScaledInstance(40, 43, 0), (int)(x - 32 + 12), (int)(y + 33 + 10), null);
					}
				}
			}
			
			//draw invalid ship placement
			else if(!valid){
				g.setColor(Color.RED);
				g.drawString("Invalid placement!", 20, 590);
				if(mouseHolding == carrier){
					if(carrier.getDirection() == Orientation.HORIZONTAL){
						g.drawImage(carrierBW.getScaledInstance(65, 65, 0), (int)(x + 33), (int)(y - 32), null);
						g.drawImage(carrierBW.getScaledInstance(65, 65, 0), (int)(x + 98), (int)(y - 32), null);
						g.drawImage(carrierBW.getScaledInstance(65, 65, 0), (int)(x + 163), (int)(y - 32), null);
						g.drawImage(carrierBW.getScaledInstance(65, 65, 0), (int)(x + 228), (int)(y - 32), null);
						g.drawImage(carrierBW.getScaledInstance(65, 65, 0), (int)(x + 293), (int)(y - 32), null);

					}
					else{
						g.drawImage(carrierBWV.getScaledInstance(65, 65, 0), (int)(x - 32), (int)(y + 33), null);
						g.drawImage(carrierBWV.getScaledInstance(65, 65, 0), (int)(x - 32), (int)(y + 98), null);
						g.drawImage(carrierBWV.getScaledInstance(65, 65, 0), (int)(x - 32), (int)(y + 163), null);
						g.drawImage(carrierBWV.getScaledInstance(65, 65, 0), (int)(x - 32), (int)(y + 228), null);
						g.drawImage(carrierBWV.getScaledInstance(65, 65, 0), (int)(x - 32), (int)(y + 293), null);					
					}
				}
				else if(mouseHolding == battlecruiser){
					if(battlecruiser.getDirection() == Orientation.HORIZONTAL){
						g.drawImage(battlecruiserBW.getScaledInstance(57, 47, 0), (int)(x + 33 + 8), (int)(y - 32 + 8), null);
						g.drawImage(battlecruiserBW.getScaledInstance(57, 47, 0), (int)(x + 98 + 8), (int)(y - 32 + 8), null);
						g.drawImage(battlecruiserBW.getScaledInstance(57, 47, 0), (int)(x + 163 + 8), (int)(y - 32 + 8), null);
					}
					else{
						g.drawImage(battlecruiserBWV.getScaledInstance(57, 47, 0), (int)(x - 35), (int)(y + 33 + 8), null);
						g.drawImage(battlecruiserBWV.getScaledInstance(57, 47, 0), (int)(x - 35), (int)(y + 98 + 8), null);
						g.drawImage(battlecruiserBWV.getScaledInstance(57, 47, 0), (int)(x - 35), (int)(y + 163 + 8), null);
					}
				}
				else if(mouseHolding == frigate){
					if(frigate.getDirection() == Orientation.HORIZONTAL){
						g.drawImage(frigateBW.getScaledInstance(60, 40, 0), (int)(x + 33), (int)(y - 32 + 11), null);
						g.drawImage(frigateBW.getScaledInstance(60, 40, 0), (int)(x + 98), (int)(y - 32 + 11), null);
					}
					else{
						g.drawImage(frigateBWV.getScaledInstance(60, 40, 0), (int)(x - 32 + 3), (int)(y + 33 + 4), null);
						g.drawImage(frigateBWV.getScaledInstance(60, 40, 0), (int)(x - 32 + 3), (int)(y + 98 + 4), null);
					}
				}
				else if(mouseHolding == inteceptor){
					if(inteceptor.getDirection() == Orientation.HORIZONTAL){
						g.drawImage(inteceptorBW.getScaledInstance(40, 43, 0), (int)(x + 33), (int)(y - 32 + 12), null);
					}
					else{
						g.drawImage(inteceptorBWV.getScaledInstance(40, 43, 0), (int)(x - 32 + 12), (int)(y + 33), null);
					}
				}
			}
		}
		
		//draw ship onto grid
		if(bc1.isOnGrid()){
			if(bc1.getDirection() == Orientation.HORIZONTAL){
				for(int i = 0; i < battlecruiser.getSize(); i++)
					g.drawImage(battlecruiserHoriz.getScaledInstance(57, 47, 0), (int)(GRID_X + bc1.getStartY()*(CELL) + 8 + CELL*i), (int)(GRID_Y + bc1.getStartX()*(CELL) + 8), null);
			}
			else{
				for(int i = 0; i < battlecruiser.getSize(); i++)
					g.drawImage(battlecruiserVert.getScaledInstance(57, 47, 0), (int)(GRID_X + bc1.getStartY()*(CELL) ), (int)(GRID_Y + bc1.getStartX()*(CELL) + 8 + CELL*i), null);
			}
		}
		if(bc2.isOnGrid()){
			if(bc2.getDirection() == Orientation.HORIZONTAL){
				for(int i = 0; i < battlecruiser.getSize(); i++)
					g.drawImage(battlecruiserHoriz.getScaledInstance(57, 47, 0), (int)(GRID_X + bc2.getStartY()*(CELL) + 8 + CELL*i), (int)(GRID_Y + bc2.getStartX()*(CELL) + 8), null);
			}
			else{
				for(int i = 0; i < battlecruiser.getSize(); i++)
					g.drawImage(battlecruiserVert.getScaledInstance(57, 47, 0), (int)(GRID_X + bc2.getStartY()*(CELL) ), (int)(GRID_Y + bc2.getStartX()*(CELL) + 8 + CELL*i), null);
			}
		}
		if(c1.isOnGrid()){
			if(c1.getDirection() == Orientation.HORIZONTAL){
				for(int i = 0; i < carrier.getSize(); i++)
					g.drawImage(carrierHoriz.getScaledInstance(65, 65, 0), (int)(GRID_X + c1.getStartY()*(CELL) + CELL*i), (int)(GRID_Y + c1.getStartX()*(CELL) ), null);
			}
			else{
				for(int i = 0; i < carrier.getSize(); i++)
					g.drawImage(carrierVert.getScaledInstance(65, 65, 0), (int)(GRID_X + c1.getStartY()*(CELL) ), (int)(GRID_Y + c1.getStartX()*(CELL) + CELL*i), null);
			}
		}
		if(f1.isOnGrid()){
			if(f1.getDirection() == Orientation.HORIZONTAL){
				for(int i = 0; i < frigate.getSize(); i++)
					g.drawImage(frigateHoriz.getScaledInstance(60, 40, 0), (int)(GRID_X + f1.getStartY()*(CELL) + CELL*i), (int)(GRID_Y + f1.getStartX()*(CELL) + 10), null);
			}
			else{
				for(int i = 0; i < frigate.getSize(); i++)
					g.drawImage(frigateVert.getScaledInstance(60, 40, 0), (int)(GRID_X + f1.getStartY()*(CELL) + 3), (int)(GRID_Y + f1.getStartX()*(CELL) + CELL*i + 4), null);
			}
		}
		if(f2.isOnGrid()){
			if(f2.getDirection() == Orientation.HORIZONTAL){
				for(int i = 0; i < frigate.getSize(); i++)
					g.drawImage(frigateHoriz.getScaledInstance(60, 40, 0), (int)(GRID_X + f2.getStartY()*(CELL) + CELL*i), (int)(GRID_Y + f2.getStartX()*(CELL) + 10), null);
			}
			else{
				for(int i = 0; i < frigate.getSize(); i++)
					g.drawImage(frigateVert.getScaledInstance(60, 40, 0), (int)(GRID_X + f2.getStartY()*(CELL) + 3), (int)(GRID_Y + f2.getStartX()*(CELL) + CELL*i + 4), null);
			}
		}
		if(f3.isOnGrid()){
			if(f3.getDirection() == Orientation.HORIZONTAL){
				for(int i = 0; i < frigate.getSize(); i++)
					g.drawImage(frigateHoriz.getScaledInstance(60, 40, 0), (int)(GRID_X + f3.getStartY()*(CELL) + CELL*i), (int)(GRID_Y + f3.getStartX()*(CELL) + 10), null);
			}
			else{
				for(int i = 0; i < frigate.getSize(); i++)
					g.drawImage(frigateVert.getScaledInstance(60, 40, 0), (int)(GRID_X + f3.getStartY()*(CELL) + 3), (int)(GRID_Y + f3.getStartX()*(CELL) + CELL*i + 4), null);
			}
		}
		if(i1.isOnGrid()){
			if(i1.getDirection() == Orientation.HORIZONTAL){
				for(int i = 0; i < inteceptor.getSize(); i++)
					g.drawImage(inteceptorHoriz.getScaledInstance(40, 43, 0), (int)(GRID_X + i1.getStartY()*(CELL) + CELL*i + 10), (int)(GRID_Y + i1.getStartX()*(CELL) + 10), null);
			}
			else{
				for(int i = 0; i < inteceptor.getSize(); i++)
					g.drawImage(inteceptorVert.getScaledInstance(40, 43, 0), (int)(GRID_X + i1.getStartY()*(CELL) + 10), (int)(GRID_Y + i1.getStartX()*(CELL) + CELL*i + 10), null);
			}
		}
		if(i2.isOnGrid()){
			if(i2.getDirection() == Orientation.HORIZONTAL){
				for(int i = 0; i < inteceptor.getSize(); i++)
					g.drawImage(inteceptorHoriz.getScaledInstance(40, 43, 0), (int)(GRID_X + i2.getStartY()*(CELL) + CELL*i + 10), (int)(GRID_Y + i2.getStartX()*(CELL) + 10), null);
			}
			else{
				for(int i = 0; i < inteceptor.getSize(); i++)
					g.drawImage(inteceptorVert.getScaledInstance(40, 43, 0), (int)(GRID_X + i2.getStartY()*(CELL) + 10), (int)(GRID_Y + i2.getStartX()*(CELL) + CELL*i + 10), null);
			}
		}
		if(i3.isOnGrid()){
			if(i3.getDirection() == Orientation.HORIZONTAL){
				for(int i = 0; i < inteceptor.getSize(); i++)
					g.drawImage(inteceptorHoriz.getScaledInstance(40, 43, 0), (int)(GRID_X + i3.getStartY()*(CELL) + CELL*i + 10), (int)(GRID_Y + i3.getStartX()*(CELL) + 10), null);
			}
			else{
				for(int i = 0; i < inteceptor.getSize(); i++)
					g.drawImage(inteceptorVert.getScaledInstance(40, 43, 0), (int)(GRID_X + i3.getStartY()*(CELL) + 10), (int)(GRID_Y + i3.getStartX()*(CELL) + CELL*i + 10), null);
			}
		}
		if(i4.isOnGrid()){
			if(i4.getDirection() == Orientation.HORIZONTAL){
				for(int i = 0; i < inteceptor.getSize(); i++)
					g.drawImage(inteceptorHoriz.getScaledInstance(40, 43, 0), (int)(GRID_X + i4.getStartY()*(CELL) + CELL*i + 10), (int)(GRID_Y + i4.getStartX()*(CELL) + 10), null);
			}
			else{
				for(int i = 0; i < inteceptor.getSize(); i++)
					g.drawImage(inteceptorVert.getScaledInstance(40, 43, 0), (int)(GRID_X + i4.getStartY()*(CELL) + 10), (int)(GRID_Y + i4.getStartX()*(CELL) + CELL*i + 10), null);
			}
		}
	}
}
