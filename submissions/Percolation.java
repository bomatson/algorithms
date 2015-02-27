public class Percolation {
    private static final int BLOCKED = 0;
    private static final int OPEN = 1;
    private enum Neighbors { TOP, RIGHT, BOTTOM, LEFT }
    private int n;
    private int totalSiteCount;
    private int[][] sites;
    private WeightedQuickUnionUF connectedSites;
    private int virtualTopSiteId;
    private int virtualBottomSiteId;

    // create N-by-N sites, with all sites blocked
    
    public Percolation(int n) {
        if (n <= 0) throw new IllegalArgumentException();
        this.n = n;
        this.totalSiteCount = n * n;
        this.sites = new int[n][n];
        this.connectedSites = new WeightedQuickUnionUF(this.totalSiteCount + 2);
        this.virtualTopSiteId = this.totalSiteCount;
        this.virtualBottomSiteId = this.totalSiteCount + 1;

        for (int i = 0; i < n; i++) {
            this.connectedSites.union(virtualTopSiteId, i);
            this.connectedSites.union(virtualBottomSiteId,
                                      (this.totalSiteCount - 1 - i));
            for (int j = 0; j < n; j++) {
                this.sites[i][j] = BLOCKED;
            }
        }
    }

    // open site (row i, column j) if it is not open already
    public void open(int i, int j) {
        if (i > this.sites.length || j > this.sites.length) 
            throw new IndexOutOfBoundsException();
        if (i <= 0 || j <= 0) throw new IndexOutOfBoundsException();
        int rowIndex = i - 1;
        int columnIndex = j - 1;
        
        // how does this get you the site id?
        int siteId = (rowIndex * this.n) + columnIndex;

        for (Neighbors neighbor: Neighbors.values()) {
            int neighborRowIndex = rowIndex;
            int neighborColumnIndex = columnIndex;
            if (neighbor == Neighbors.TOP) neighborRowIndex--;
            if (neighbor == Neighbors.RIGHT) neighborColumnIndex++;
            if (neighbor == Neighbors.BOTTOM) neighborRowIndex++;
            if (neighbor == Neighbors.LEFT) neighborColumnIndex--;
            if (neighborRowIndex < 0 || neighborRowIndex >= this.n 
                    || neighborColumnIndex < 0 || neighborColumnIndex >= this.n)
                continue;

            if (this.sites[neighborRowIndex][neighborColumnIndex] == OPEN) {
                int neighborSiteId = 
                    (neighborRowIndex * this.n) + neighborColumnIndex;
                if (!connectedSites.connected(siteId, neighborSiteId)) {
                    connectedSites.union(siteId, neighborSiteId);
                }
                //why add one to the neighboring row index? Not sure this step is necessary
                if (isFull(neighborRowIndex + 1, neighborColumnIndex + 1)) {
                    this.connectedSites.union(this.virtualTopSiteId, siteId);
                }
            }
        }

        this.sites[rowIndex][columnIndex] = OPEN;
    }

    // is site (row i, column j) open?
    public boolean isOpen(int i, int j) {
        if (i > this.sites.length || j > this.sites.length) 
            throw new IndexOutOfBoundsException();
        if (i <= 0 || j <= 0) throw new IndexOutOfBoundsException();

        return this.sites[i - 1][j - 1] == OPEN;
    }

    /**
     * A full site is an open site that can be connected to an open site 
     * in the top row via a chain of neighboring
     * (left, right, up, down) open sites.
     */
    public boolean isFull(int i, int j) {
        if (i > this.sites.length || j > this.sites.length) 
            throw new IndexOutOfBoundsException();
        if (i <= 0 || j <= 0) throw new IndexOutOfBoundsException();
        int rowIndex = i - 1;
        int columnIndex = j - 1;
        int siteId = (rowIndex * this.n) + columnIndex;

        return isOpen(i, j) 
            && this.connectedSites.connected(siteId, virtualTopSiteId);
    }

    /**
     * We say the system percolates if there is a full site 
     * in the bottom row. In other words, a system percolates if
     * we fill all open sites connected to the top row and that 
     * process fills some open site on the bottom row.
     */
    public boolean percolates() {
        if (this.totalSiteCount == 1)
            return isFull(1, 1);
        return this.connectedSites.connected(virtualBottomSiteId, virtualTopSiteId);
    }
}