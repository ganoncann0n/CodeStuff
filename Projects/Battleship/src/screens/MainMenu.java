package screens;

import game.Game;




import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.*;

import java.awt.*;


public class MainMenu extends JFrame implements ActionListener{
	
	public JPanel contentPanel;
	public JPanel mainPanel;
	
	public MainMenuBackground mainMenuBackground;
	public ShipSelect shipSelect;
	public FieldScreen fieldScreen;
	
	public JButton startButton;
	public JButton continueButton;
	
	public ImageIcon mainIcon;
	
	public CardLayout cardLayout = new CardLayout();
	
	public Game game = null;
	
	//main
	public static void main(String[] args){
		MainMenu screen = new MainMenu();
		screen.setVisible(true);
	}
	
	//constructor
	public MainMenu(){
		layoutPanel();
	}
	
	private void layoutPanel() {
		setSize(1280, 720);
		setTitle("Battleship");
		setLocationRelativeTo(null);
		setResizable(false);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		String iconPath = ("images" + File.separator + "icon.png");
		
		if(iconPath != null){
			mainIcon = new ImageIcon(("images" + File.separator + "icon.png"));
			setIconImage(mainIcon.getImage());
		}
		
		contentPanel = new JPanel();
		contentPanel.setLayout(cardLayout);
		
		//JPanel Main Menu
		mainMenuBackground = new MainMenuBackground();
		mainPanel = new JPanel();
		
		mainPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 50, 50));
		
		mainPanel.setOpaque(false);

		startButton = new JButton("New Game");
		continueButton = new JButton("Continue Game");
		
		startButton.addActionListener(this);
		continueButton.addActionListener(this);
		
		startButton.setPreferredSize(new Dimension(150, 60));
		continueButton.setPreferredSize(new Dimension(150, 60));
		
		mainPanel.add(startButton);
		mainPanel.add(continueButton);

		mainMenuBackground.add(mainPanel, BorderLayout.SOUTH);
		
		contentPanel.add(mainMenuBackground, "mainMenu");
		cardLayout.show(contentPanel,"mainMenu");
		
		add(contentPanel);
	}

	//action listener
	public void actionPerformed(ActionEvent e) {
		//switches to ship selector screen for a new game
		if(e.getSource() == startButton){
			shipSelect = new ShipSelect(contentPanel);
			contentPanel.add(shipSelect, "shipSelect");
			CardLayout cardLayout = (CardLayout) contentPanel.getLayout();
			cardLayout.show(contentPanel, "shipSelect");
			
		}
		//loads previous game and switches to game view
		else{
			game = Game.loadData();
			
			fieldScreen = new FieldScreen(contentPanel, game);
			contentPanel.add(fieldScreen, "fieldScreen");
			CardLayout cardLayout = (CardLayout) contentPanel.getLayout();
			cardLayout.show(contentPanel, "fieldScreen");
			return;
		}
	}


	private class MainMenuBackground extends JPanel {

		  BufferedImage title, mainMenuBackground;
		  	
		  public MainMenuBackground(){
		  	loadImages();
		  	layoutGUI();
		  }
		  	
		  public void loadImages(){
		  	try{
		  		mainMenuBackground = ImageIO.read(new File("images" + File.separator + "mainMenuBackground.png"));
		  	}catch(IOException e){
		  		System.out.println("Could not fine mainMenuBackground.png");
		  	}
		  	
		  	try{
		  		title = ImageIO.read(new File("images" + File.separator + "Title.png"));
		  	}catch(IOException e){
		  		System.out.println("Could not find Title.png for the main menu screen");
		  	}
		  }

		  public void layoutGUI(){
		  	setLayout(new BorderLayout());
		  }

	
		  public void paintComponent(Graphics g)
		  {
		  	g.drawImage(mainMenuBackground, 0, 0, null); 
		  	g.drawImage(title, 200, 200, null);
		  }
	}
}
