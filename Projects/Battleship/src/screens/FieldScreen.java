package screens;

import game.Computer;


import game.Field;
import game.Game;
import game.Human;
import game.Orientation;
import game.State;
import game.VesselType;

import java.awt.CardLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
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
import javax.swing.JButton;
import javax.swing.JPanel;

@SuppressWarnings("serial")public class FieldScreen extends JPanel{

	public JPanel contentPanel;
	
	public JButton saveGame, quitGame, endTurn;
	
	public BufferedImage battlecruiserSheet, carrierSheet, frigateSheet, 
	  battlecruiserHoriz, battlecruiserVert, carrierHoriz, carrierVert, frigateHoriz, frigateVert,
	  inteceptorHoriz, inteceptorVert;
	
	public BufferedImage battlecruiserSheetBW, battlecruiserBW, battlecruiserBWV, inteceptorBW, inteceptorBWV, carrierBW, carrierBWV, frigateBW, frigateBWV;
	public BufferedImage battlecruiserOut, battlecruiserOutV, battlecruiserOutSheet, inteceptorOut, inteceptorOutV, carrierOut, carrierOutV, frigateOut, frigateOutV;
	public BufferedImage space, grid, Cgrid;
	public BufferedImage miss, hit;
	
	public Field field;
	public Computer computer;
	
	public Game game;
	
	public boolean ComputerFinished = false;
	
	public int x,y;
	public int hitFlag = 0;
	
	public boolean selectOut = false, selected = false;
	
	public static int HUMAN_GRID_X = 100;
	public static int HUMAN_GRID_Y = 17;
	public static int HUMAN_CELL = 65;
	
	public static int C_CELL = 40;
	public static int C_GRID_X = 800;
	public static int C_GRID_Y = 34;

	//constructor 1
	public FieldScreen(JPanel contentPanel, Human p) {
		this.contentPanel = contentPanel;	
		field = new Field();
		computer = new Computer();
		game = new Game();
		
		computer.generateBoard();
		
		field.setHuman(p);
		field.setComputer(computer);
		
		game.setField(field);
		
		loadImages();
		layoutPanel();
		createListeners();
	}
	
	//overload constructor for load game
	public FieldScreen(JPanel contentPanel, Game g) {
		this.contentPanel = contentPanel;	
		
		game = g;
		field = game.getField();
		computer = field.getComputer();
		
		loadImages();
		layoutPanel();
		createListeners();
	}

	private void loadImages() {
		try{
			//load sheets
			space = ImageIO.read(new File("images" + File.separator + "spaceBattle.png"));
			grid = ImageIO.read(new File("images" + File.separator + "grid.png"));
			Cgrid = ImageIO.read(new File("images" + File.separator + "Cgrid.png"));
			miss = ImageIO.read(new File("images" + File.separator + "miss.png"));
			hit = ImageIO.read(new File("images" + File.separator + "hit.png"));
			battlecruiserSheet = ImageIO.read(new File("images" + File.separator + "battlecruiser.png"));
			battlecruiserSheetBW = ImageIO.read(new File("images" + File.separator + "battlecruiserBW.png"));
			battlecruiserOutSheet = ImageIO.read(new File("images" + File.separator + "battlecruiserOut.png"));
			
			//load battlecruiser subimages
			battlecruiserHoriz = battlecruiserSheet.getSubimage(15, 160, 95, 70);
			battlecruiserVert = battlecruiserSheet.getSubimage(10, 0, 85, 70);
			battlecruiserBW = battlecruiserSheetBW.getSubimage(15, 160, 95, 70);
			battlecruiserBWV = ImageIO.read(new File("images" + File.separator + "battlecruiserBWV.png"));
			battlecruiserOutV = ImageIO.read(new File("images" + File.separator + "battlecruiserVOut.png"));
			battlecruiserOut = battlecruiserOutSheet.getSubimage(15, 160, 95, 70);
			
			//load carrier subimages
			carrierHoriz = ImageIO.read(new File("images" + File.separator + "carrierH.png"));
			carrierVert = ImageIO.read(new File("images" + File.separator + "carrierV.png"));
			carrierBW = ImageIO.read(new File("images" + File.separator + "carrierBW.png"));
			carrierBWV = ImageIO.read(new File("images" + File.separator + "carrierBWV.png"));
			carrierOut = ImageIO.read(new File("images" + File.separator + "carrierOut.png"));
			carrierOutV = ImageIO.read(new File("images" + File.separator + "carrierOutV.png"));
			
			//load frigate subimages
			frigateHoriz = ImageIO.read(new File("images" + File.separator + "frigateH.png"));
			frigateVert = ImageIO.read(new File("images" + File.separator + "frigateV.png"));
			frigateBW = ImageIO.read(new File("images" + File.separator + "frigateBW.png"));
			frigateBWV = ImageIO.read(new File("images" + File.separator + "frigateBWV.png"));
			frigateOut = ImageIO.read(new File("images" + File.separator + "frigateSelected.png"));
			frigateOutV = ImageIO.read(new File("images" + File.separator + "frigateOutV.png"));
			
			
			//load interceptor subimages
			inteceptorHoriz = ImageIO.read(new File("images" + File.separator + "interceptorH.png"));
			inteceptorVert = ImageIO.read(new File("images" + File.separator + "interceptorV.png"));
			inteceptorOut = ImageIO.read(new File("images" + File.separator + "interceptorHout.png"));
			inteceptorOutV = ImageIO.read(new File("images" + File.separator + "inteceptorOutV.png"));
			inteceptorBW = ImageIO.read(new File("images" + File.separator + "inteceptorBW.png"));
			inteceptorBWV = ImageIO.read(new File("images" + File.separator + "inteceptorBWV.png"));
			
		}catch(IOException e){
			System.out.println("Could not load vessel images");
		}
	}

	private void layoutPanel() {
		setLayout(null);
		
		saveGame = new JButton("Save Game");
		quitGame = new JButton("Quit to Main Menu");
		endTurn = new JButton("End your turn");
		
		saveGame.setSize(new Dimension(150, 30));
		quitGame.setSize(new Dimension(150, 30));
		endTurn.setSize(new Dimension(150, 60));
		
		saveGame.setLocation(800, 640);
		quitGame.setLocation(1050, 640);
		endTurn.setLocation(925, 500);
		
		add(saveGame);
		add(quitGame);
		add(endTurn);
	}

	private void createListeners() {
		this.addMouseMotionListener(new HighlightCell());
		this.addMouseListener(new SelectCell());
		quitGame.addActionListener(new BackToMain());
		saveGame.addActionListener(new SaveGame());
		endTurn.addActionListener(new EndTurn());
	}
	
	private class HighlightCell implements MouseMotionListener{

		@Override
		public void mouseDragged(MouseEvent arg0) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void mouseMoved(MouseEvent arg0) {
			/*
			selectOut = false;
			
			for(int i = 0; i < 10; i++){
				for(int k = 0; k < 10; k++){
					if((x >= C_GRID_X+(i*C_CELL)) && (x < C_GRID_X+((i+1)*C_CELL)) && (y >= C_GRID_Y+(k*C_CELL)) && (y < C_GRID_Y+((k+1)*C_CELL))){
						selectOut = true;
						repaint();
					}
				}
			}
			*/
		}
	}
	
	private class SelectCell implements MouseListener{

		@Override
		public void mouseClicked(MouseEvent arg0) {
			
			//game loop
			x = arg0.getX();
			y = arg0.getY();
			for(int i = 0; i < 10; i++){
				for(int k = 0; k < 10; k++){
					if((x >= C_GRID_X+(i*C_CELL)) && (x < C_GRID_X+((i+1)*C_CELL)) && (y >= C_GRID_Y+(k*C_CELL)) && (y < C_GRID_Y+((k+1)*C_CELL))){
						if((field.getHuman().getTurnFlag()) && (game.getGameOver() == false)){
							ComputerFinished = false;
							game.gameTurn(k, i);
							repaint();
						}
					}
				}
			}
		}

		@Override
		public void mouseEntered(MouseEvent arg0) {
			// TODO Auto-generated method stub
			//not used
		}

		@Override
		public void mouseExited(MouseEvent arg0) {
			// TODO Auto-generated method stub
			//not used
		}

		@Override
		public void mousePressed(MouseEvent arg0) {
			// TODO Auto-generated method stub
			//not used
		}

		@Override
		public void mouseReleased(MouseEvent e) {
			// TODO Auto-generated method stub
			//not used
		}
		
	}
	
	private class BackToMain implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			CardLayout cardLayout = (CardLayout) contentPanel.getLayout();
			cardLayout.show(contentPanel, "mainMenu");
		}
		
	}
	
	private class SaveGame implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			Game.saveData(game);
		}
		
	}
	
	private class EndTurn implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent arg0) {
			//runs computers turn
			hitFlag = 0;
			computer.setHitFlag(0);
			field.getHuman().setTurn(false);
			field.getHuman().setHTurn(false);
			computer.setTurn(true);
			
			game.gameTurn(0, 0);
			if(field.getComputer().getHTurn() == true)
				game.gameTurn(0, 0);
			
			hitFlag = computer.getHit();
			ComputerFinished = true;
			repaint();
		}
	}
	
	public void paintComponent(Graphics g){
		
		//draw background images
		g.drawImage(space.getScaledInstance(1280, 720, 0), 0, 0, null);
		g.drawImage(grid, HUMAN_GRID_X, HUMAN_GRID_Y, null);
		g.drawImage(Cgrid, C_GRID_X, C_GRID_Y, null);
		
		//draw human fleet
		for(int i = 0; i < field.getHuman().getFleet().size(); i++){
			
			//draw carrier
			if(field.getHuman().getFleet().get(i).getType() == VesselType.CARRIER){
				if(field.getHuman().getFleet().get(i).getDirection() == Orientation.HORIZONTAL){
					for(int k = 0; k < field.getHuman().getFleet().get(i).getSize(); k++)
						g.drawImage(carrierHoriz.getScaledInstance(65, 65, 0), (int)(HUMAN_GRID_X + field.getHuman().getFleet().get(i).getStartY()*(HUMAN_CELL) + HUMAN_CELL*k), (int)(HUMAN_GRID_Y + field.getHuman().getFleet().get(i).getStartX()*(HUMAN_CELL) ), null);
				}
				else{
					for(int k = 0; k < field.getHuman().getFleet().get(i).getSize(); k++)
						g.drawImage(carrierVert.getScaledInstance(65, 65, 0), (int)(HUMAN_GRID_X + field.getHuman().getFleet().get(i).getStartY()*(HUMAN_CELL) ), (int)(HUMAN_GRID_Y + field.getHuman().getFleet().get(i).getStartX()*(HUMAN_CELL) + HUMAN_CELL*k), null);
				}
			}
			//draw battlecruisers
			if(field.getHuman().getFleet().get(i).getType() == VesselType.BATTLECRUISER){
				if(field.getHuman().getFleet().get(i).getDirection() == Orientation.HORIZONTAL){
					for(int k = 0; k < field.getHuman().getFleet().get(i).getSize(); k++)
						g.drawImage(battlecruiserHoriz.getScaledInstance(57, 47, 0), (int)(HUMAN_GRID_X + field.getHuman().getFleet().get(i).getStartY()*(HUMAN_CELL) + 8 + HUMAN_CELL*k), (int)(HUMAN_GRID_Y + field.getHuman().getFleet().get(i).getStartX()*(HUMAN_CELL) + 8), null);
				}
				else{
					for(int k = 0; k < field.getHuman().getFleet().get(i).getSize(); k++)
						g.drawImage(battlecruiserVert.getScaledInstance(57, 47, 0), (int)(HUMAN_GRID_X + field.getHuman().getFleet().get(i).getStartY()*(HUMAN_CELL) ), (int)(HUMAN_GRID_Y + field.getHuman().getFleet().get(i).getStartX()*(HUMAN_CELL) + 8 + HUMAN_CELL*k), null);
				}
			}
			//draw frigates
			if(field.getHuman().getFleet().get(i).getType() == VesselType.FRIGATE){
				if(field.getHuman().getFleet().get(i).getDirection() == Orientation.HORIZONTAL){
					for(int k = 0; k < field.getHuman().getFleet().get(i).getSize(); k++)
						g.drawImage(frigateHoriz.getScaledInstance(60, 40, 0), (int)(HUMAN_GRID_X + field.getHuman().getFleet().get(i).getStartY()*(HUMAN_CELL) + HUMAN_CELL*k), (int)(HUMAN_GRID_Y + field.getHuman().getFleet().get(i).getStartX()*(HUMAN_CELL) + 10), null);
				}
				else{
					for(int k = 0; k < field.getHuman().getFleet().get(i).getSize(); k++)
						g.drawImage(frigateVert.getScaledInstance(60, 40, 0), (int)(HUMAN_GRID_X + field.getHuman().getFleet().get(i).getStartY()*(HUMAN_CELL) + 3 ), (int)(HUMAN_GRID_Y + field.getHuman().getFleet().get(i).getStartX()*(HUMAN_CELL) + 4 + HUMAN_CELL*k), null);
				}
			}
			//draw inteceptors
			if(field.getHuman().getFleet().get(i).getType() == VesselType.INTECEPTOR){
				if(field.getHuman().getFleet().get(i).getDirection() == Orientation.HORIZONTAL){
					for(int k = 0; k < field.getHuman().getFleet().get(i).getSize(); k++)
						g.drawImage(inteceptorHoriz.getScaledInstance(40, 43, 0), (int)(HUMAN_GRID_X + field.getHuman().getFleet().get(i).getStartY()*(HUMAN_CELL) + HUMAN_CELL*k + 10), (int)(HUMAN_GRID_Y + field.getHuman().getFleet().get(i).getStartX()*(HUMAN_CELL) + 10), null);
				}
				else{
					for(int k = 0; k < field.getHuman().getFleet().get(i).getSize(); k++)
						g.drawImage(inteceptorVert.getScaledInstance(40, 43, 0), (int)(HUMAN_GRID_X + field.getHuman().getFleet().get(i).getStartY()*(HUMAN_CELL) + 10 ), (int)(HUMAN_GRID_Y + field.getHuman().getFleet().get(i).getStartX()*(HUMAN_CELL) + 10 + HUMAN_CELL*k), null);
				}
			}
		}
		
		//draw human board hits/misses
		for(int i = 0; i < 10; i++){
			for(int k = 0; k < 10; k++){
				if(field.getHuman().getBoard()[i][k].getStatus() == State.HIT){
					g.drawImage(hit.getScaledInstance(45, 45, 0), HUMAN_GRID_X + HUMAN_CELL*k + 8, HUMAN_GRID_Y + HUMAN_CELL*i + 8, null);
				}
			}
		}
		for(int i = 0; i < 10; i++){
			for(int k = 0; k < 10; k++){
				if(field.getHuman().getBoard()[i][k].getStatus() == State.MISS){
					g.drawImage(miss.getScaledInstance(45, 45, 0), HUMAN_GRID_X + HUMAN_CELL*k + 8, HUMAN_GRID_Y + HUMAN_CELL*i + 8, null);
				}
			}
		}
		
		//draw computer board hits/misses
		for(int i = 0; i < 10; i++){
			for(int k = 0; k < 10; k++){
				if(field.getComputer().getBoard()[i][k].getStatus() == State.HIT){
					g.drawImage(hit.getScaledInstance(30, 30, 0), C_GRID_X +C_CELL*k + 4, C_GRID_Y + C_CELL*i + 4, null);
				}
			}
		}
		for(int i = 0; i < 10; i++){
			for(int k = 0; k < 10; k++){
				if(field.getComputer().getBoard()[i][k].getStatus() == State.MISS){
					g.drawImage(miss.getScaledInstance(30, 30, 0), C_GRID_X +C_CELL*k + 4, C_GRID_Y + C_CELL*i + 4, null);
				}
			}
		}
		
		/*
		//highlighting
		if(selectOut){
			for(int i = 0; i < 10; i++){
				for(int k = 0; k < 10; k++){
					if((x >= C_GRID_X+(i*C_CELL)) && (x < C_GRID_X+((i+1)*C_CELL)) && (y >= C_GRID_Y+(k*C_CELL)) && (y < C_GRID_Y+((k+1)*C_CELL))){
						g.setColor(Color.BLUE);
						g.drawRoundRect(C_GRID_X + i*C_CELL, C_GRID_Y + k*C_CELL, C_CELL, C_CELL, 4, 4);
					}
				}
			}
		}
		
		//selected
		if(selected){
			for(int i = 0; i < 10; i++){
				for(int k = 0; k < 10; k++){
					if((x >= C_GRID_X+(i*C_CELL)) && (x < C_GRID_X+((i+1)*C_CELL)) && (y >= C_GRID_Y+(k*C_CELL)) && (y < C_GRID_Y+((k+1)*C_CELL))){
						g.setColor(Color.BLUE);
						g.drawRoundRect(C_GRID_X + i*C_CELL, C_GRID_Y + k*C_CELL, C_CELL, C_CELL, 4, 4);
					}
				}
			}
		}
		*/
		//hud
		//human hits/misses
		if(!game.getGameOver()){
			if(field.getHuman().getTurnFlag() && (field.getHuman().getHTurn() == false)){
				g.setFont(new Font("TimesRoman", Font.BOLD, 14));
				g.setColor(Color.WHITE);
				g.drawString("Your turn, click an enemy cell to shoot!", 875, 600);
			}
			if(field.getHuman().getHTurn() == true){
				g.setFont(new Font("TimesRoman", Font.BOLD, 14));
				g.setColor(Color.RED);
				g.drawString("You hit! You may shoot once more", 875, 600);
			}
			if(!field.getHuman().getTurnFlag()){
				g.setFont(new Font("TimesRoman", Font.BOLD, 14));
				g.setColor(Color.WHITE);
				g.drawString("Your turn is over, press \"End your turn\"", 875, 600);
			}
		}
		//computer hits/misses
		if(!game.getGameOver()){
			g.setColor(Color.WHITE);
			if(ComputerFinished){
				if(hitFlag > 0)
					g.drawString("Your fleet was hit "  + hitFlag + " time(s)", 875, 580);
				}
		}
		//victory
		if(game.getGameOver()){
			saveGame.setEnabled(false);
			endTurn.setEnabled(false);
			g.setColor(Color.BLUE);
			g.setFont(new Font("TimesRoman", Font.BOLD, 90));
			
			if(game.getField().getHuman().isAlive())
				g.drawString("VICTORY!", 450, 360);
			else{
				g.setColor(Color.RED);
				g.drawString("DEFEAT!", 450, 360);
			}
		}
	}
}
