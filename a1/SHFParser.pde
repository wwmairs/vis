import java.util.*; 

class SHFParser {
  // A parser for a .shf file for building Trees of RectangleNodes
  
  // the root node of the rectangleNodes
  private RectangleNode rootNode;
  
  // SHFParser Constructor
  // Args:
  //   * String filePath - the relative path to the .shf file to parse
  SHFParser(String filePath) {
    
    // Begin by loading an array of strings from the file
    String[] lines = loadStrings(filePath);    
    
    // Initialize some helpful integers using the specified counts in the .shf file
    int numberOfLeafNodes = Integer.parseInt(lines[0]);
    int numberOfRelationships = Integer.parseInt(lines[numberOfLeafNodes + 1]);
    int maxIndex = 0;
    
    // Iterate through the nodes and find the maximum nodeID so we can create an array of nodes and not exceed the length
    for (int i = 1; i < lines.length; i++) {
      
      // Only update the maxIndex when looking at a line with an index instead of a count
      if (i != numberOfLeafNodes + 1) {
        
        // Update the new maxIndex using the maximum of the current maxIndex and the given index from the input line
        maxIndex = max(maxIndex, Integer.parseInt(split(lines[i], " ")[0]));
      }
    }
    
    // Create an array of RectangleNodes the length of the number of nodes we have (maxIndex)
    RectangleNode[] nodes = new RectangleNode[maxIndex+1];
    
    // Initalize every element in the array to be a new RectangleNode
    for (int i = 0; i < maxIndex + 1; i++) {
      nodes[i] = new RectangleNode(); 
    }

    // Create a helper array to get info from the .shf file
    String[] infoStrings = new String[2];
    
    // Iterate over the first set of data, the child nodes, and set the area of the child nodes (via their
    // corresponding ID) to the specified area
    for (int index = 1; index <= numberOfLeafNodes; index++) {
      
      // Get the info from the given line (splitting the string by a space)
      infoStrings = split(lines[index], " ");
      
      // Set the area of the specifed node, converting the given strings into integers
      nodes[Integer.parseInt(infoStrings[0])].setArea(Integer.parseInt(infoStrings[1]));  
    }
    
    // Create integers to store the parent and child indexes for each relationship in the file
    int parentIndex;
    int childIndex;
    
    // Iterate over the second half of the input data: the parent/child relationships
    for (int index = numberOfLeafNodes + 2; index <= numberOfLeafNodes + numberOfRelationships + 1; index++) {
      
      // Get the parent and child indexes from the data file
      infoStrings = split(lines[index], " ");
      parentIndex = Integer.parseInt(infoStrings[0]);
      childIndex = Integer.parseInt(infoStrings[1]);
      
      // For each child index, set its parent (which also removes the child from it's current parent's children array)
      // and append the child to the new parent's child array
      nodes[childIndex].setParent(nodes[parentIndex]);
    }
    
    // Find the root node
    int potentialRootNodesCount = 0;
    
    // Iterate over all the nodes and find all the nodes that do not have parents
    for (int i = 0; i < nodes.length; i++) {
      if (nodes[i].parent == null) {
        potentialRootNodesCount++;
        rootNode = nodes[i];
      }
    }
     
    // Ensure that at least one node does not have a parent
    assert(potentialRootNodesCount > 0);
    
    // If more than one node does not have a parent, create a new root node and set all of the parentless nodes' parent
    // to the new root node
    if (potentialRootNodesCount > 1) {
      rootNode = new RectangleNode();
      
      // Find all the parentless nodes and set their parent to the root node
      for (int i = 0; i < nodes.length; i++) {
        if (nodes[i].parent == null) {
          nodes[i].setParent(rootNode);
        }
      }
    }
    
    // Sort all of the children
    this.rootNode.sortChildren();
    
  }
  
  // Get the root node 
  RectangleNode getRootNode() {
    return rootNode; 
  }
  
  
}